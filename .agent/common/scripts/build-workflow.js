#!/usr/bin/env node
/**
 * Workflow 빌드 스크립트 (3-tier scope chain)
 *
 * 3단계 스코프 체인으로 소스를 해석하여 workflow skill을 빌드한다:
 *   project (.dynamic-builder/build-workflow/src/)  ← 최우선
 *   global  (~/.dynamic-builder/build-workflow/src/)
 *   default (플러그인 내부 src/)
 *
 * details는 스코프 순서로 오버라이드.
 * 템플릿은 스코프별로 수집하되, 상위 스코프가 같은 이름을 가리면 하위는 스킵.
 * 빌드 출력 위치는 템플릿의 소스 스코프에 따라 결정:
 *   project 템플릿 → {project}/{AGENT_HOME_NAME}/skills/
 *   global/default 템플릿 → $AGENT_HOME/skills/
 *
 * 사용법:
 *   node build-workflow.js
 *   node build-workflow.js --watch
 *   node build-workflow.js --clean
 */

const fs = require("fs");
const os = require("os");
const path = require("path");

// ── 프로젝트 루트 탐색 ───────────────────────────────────────
function findProjectRoot() {
  const homeDb = path.join(os.homedir(), ".dynamic-builder");
  let dir;
  try {
    dir = process.cwd();
  } catch {
    return null;
  }
  while (dir !== path.dirname(dir)) {
    const candidate = path.join(dir, ".dynamic-builder");
    if (fs.existsSync(candidate) && candidate !== homeDb) {
      return dir;
    }
    dir = path.dirname(dir);
  }
  return null;
}

// ── 경로 설정 ──────────────────────────────────────────────
if (!process.env.AGENT_HOME) {
  console.error("[ERROR] AGENT_HOME 환경변수가 설정되지 않았습니다.");
  process.exit(1);
}
const AGENT_HOME = process.env.AGENT_HOME;
const PLUGIN_DIR = path.join(AGENT_HOME, "plugins/marketplaces/dynamic-builder");
const SKILL_DIR = path.join(PLUGIN_DIR, "skills/build-workflow");
const AGENT_DIR = AGENT_HOME;
const DYNAMIC_BUILDER_DIR = path.join(os.homedir(), ".dynamic-builder");
const PROJECT_ROOT = findProjectRoot();

const AGENTS_BUILD_DIRS = [
  PROJECT_ROOT && path.join(PROJECT_ROOT, path.basename(AGENT_HOME), "agents"),
  path.join(AGENT_DIR, "agents"),
].filter(Boolean);
const REFERENCES_DIR = path.join(AGENT_DIR, "references");
const MANIFEST_PATH = path.join(DYNAMIC_BUILDER_DIR, "build-workflow/.workflow-details-manifest.local.json");

// 스코프 정의 (읽기 + 쓰기)
const SCOPES = [
  PROJECT_ROOT && {
    name: "project",
    srcDir: path.join(PROJECT_ROOT, ".dynamic-builder/build-workflow/src"),
    outputDir: path.join(PROJECT_ROOT, path.basename(AGENT_HOME), "skills"),
    indexFile: path.join(PROJECT_ROOT, ".dynamic-builder/build-workflow/.build-index.local.json"),
  },
  {
    name: "global",
    srcDir: path.join(DYNAMIC_BUILDER_DIR, "build-workflow/src"),
    outputDir: path.join(AGENT_DIR, "skills"),
    indexFile: path.join(DYNAMIC_BUILDER_DIR, "build-workflow/.build-index.local.json"),
  },
  {
    name: "default",
    srcDir: path.join(SKILL_DIR, "src"),
    outputDir: path.join(AGENT_DIR, "skills"),
    indexFile: path.join(DYNAMIC_BUILDER_DIR, "build-workflow/.build-index.local.json"),
  },
].filter(Boolean);

// ── 빌드 인덱스 ────────────────────────────────────────────
function loadBuildIndex(indexFile) {
  if (!fs.existsSync(indexFile)) return { generated: [] };
  try {
    return JSON.parse(fs.readFileSync(indexFile, "utf-8"));
  } catch {
    return { generated: [] };
  }
}

function saveBuildIndex(indexFile, index) {
  fs.mkdirSync(path.dirname(indexFile), { recursive: true });
  fs.writeFileSync(indexFile, JSON.stringify(index, null, 2) + "\n", "utf-8");
}

// ── 부품 해석: 스코프 체인으로 탐색 ──────────────────────────
function resolveDetail(name) {
  for (const scope of SCOPES) {
    const filePath = path.join(scope.srcDir, "details", name);
    if (fs.existsSync(filePath)) return filePath;
  }
  return null;
}

// ── input 섹션 파서 ────────────────────────────────────────
function parseInputSection(content) {
  const inputs = {};
  const lines = content.split("\n");

  let i = 0;
  while (i < lines.length && lines[i].trim() !== "input:") i++;
  if (i >= lines.length) return inputs;
  i++;

  while (i < lines.length) {
    const line = lines[i];
    if (line.trim() === "" || line.trim().startsWith("#")) { i++; continue; }

    const indent = line.search(/\S/);
    if (indent === 0) break; // 다음 최상위 섹션

    const trimmed = line.trim();

    // 플래그 선언: "  flag-name:" 또는 "  flag-name: {}"
    if (indent <= 2 && trimmed.endsWith(":")) {
      const flagName = trimmed.slice(0, -1).trim();
      const flag = { desc: "", default: "" };
      inputs[flagName] = flag;
      i++;

      while (i < lines.length) {
        const pLine = lines[i];
        if (pLine.trim() === "" || pLine.trim().startsWith("#")) { i++; continue; }
        const pIndent = pLine.search(/\S/);
        if (pIndent <= indent) break;
        const pTrimmed = pLine.trim();

        if (pTrimmed.startsWith("desc:")) {
          flag.desc = pTrimmed.slice(5).trim().replace(/^["']|["']$/g, "");
        } else if (pTrimmed.startsWith("default:")) {
          flag.default = pTrimmed.slice(8).trim().replace(/^["']|["']$/g, "");
        }
        i++;
      }
    } else {
      i++;
    }
  }

  return inputs;
}

// ── YAML 파싱 ──────────────────────────────────────────────
function parseWorkflowYaml(filePath) {
  const content = fs.readFileSync(filePath, "utf-8");
  const agents = parseAgentsSection(content);
  const steps = parseSteps(content);
  const inputs = parseInputSection(content);

  // output-dir 파싱
  const outputDirMatch = content.match(/^output-dir:\s*(.+)$/m);
  const outputDir = outputDirMatch ? outputDirMatch[1].trim() : ".local/$ARGUMENTS";

  // flow 섹션 원문 추출
  const flowStart = content.indexOf("\nflow:");
  const flowContent = flowStart >= 0 ? content.slice(flowStart) : "";

  // flow를 구조화된 배열로 파싱
  const flowItems = flowStart >= 0 ? parseFlowSection(flowContent) : [];

  return { agents, steps, flowItems, inputs, outputDir, raw: content };
}

// ── define.agents 파서 ────────────────────────────────────
function parseAgentsSection(content) {
  const agents = {};
  const lines = content.split("\n");

  let i = 0;
  while (i < lines.length && lines[i].trim() !== "define:") i++;
  if (i >= lines.length) return agents;
  i++;

  // define: 내부에서 agents: 탐색
  while (i < lines.length) {
    const line = lines[i];
    if (line.trim() === "" || line.trim().startsWith("#")) { i++; continue; }
    const indent = line.search(/\S/);
    if (indent === 0) break; // 다음 최상위 섹션
    if (line.trim() === "agents:") {
      i++;
      // agents: 내부의 `- {alias}: {agent-name}` 파싱
      while (i < lines.length) {
        const aLine = lines[i];
        if (aLine.trim() === "" || aLine.trim().startsWith("#")) { i++; continue; }
        const aIndent = aLine.search(/\S/);
        if (aIndent <= indent) break; // agents 블록 종료
        const aTrimmed = aLine.trim();
        if (aTrimmed.startsWith("- ") && aTrimmed.includes(":")) {
          const inner = aTrimmed.slice(2).trim();
          const colonIdx = inner.indexOf(":");
          if (colonIdx > 0) {
            const alias = inner.slice(0, colonIdx).trim();
            const agentName = inner.slice(colonIdx + 1).trim();
            if (alias && agentName) {
              agents[alias] = agentName;
            }
          }
        }
        i++;
      }
      break;
    }
    if (line.trim() === "steps:") break; // agents가 없이 steps에 도달
    i++;
  }

  return agents;
}

// ── define.steps 파서 ──────────────────────────────────────
function parseSteps(content) {
  const steps = {};
  const lines = content.split("\n");

  let i = 0;
  while (i < lines.length && lines[i].trim() !== "define:") i++;
  i++;
  while (i < lines.length && lines[i].trim() !== "steps:") i++;
  i++;

  while (i < lines.length) {
    const line = lines[i];
    if (line.trim() === "" || line.trim().startsWith("#")) {
      i++;
      continue;
    }

    const indent = line.search(/\S/);
    const trimmed = line.trim();

    if (indent === 0) break;

    if (trimmed.startsWith("- ") && trimmed.endsWith(":")) {
      const stepName = trimmed.slice(2, -1).trim();
      const step = { desc: "", agent: "", shell: "", tool: "", refs: [], details: [], input: [], output: null, params: {} };
      steps[stepName] = step;

      const stepIndent = indent;
      i++;
      let currentListField = null;

      while (i < lines.length) {
        const pLine = lines[i];
        if (pLine.trim() === "" || pLine.trim().startsWith("#")) {
          i++;
          continue;
        }
        const pIndent = pLine.search(/\S/);
        const pTrimmed = pLine.trim();

        if (pIndent <= stepIndent) break;

        if (pTrimmed.startsWith("desc:")) {
          step.desc = pTrimmed.slice(5).trim().replace(/^["']|["']$/g, "");
          currentListField = null;
        } else if (pTrimmed.startsWith("agent:")) {
          step.agent = pTrimmed.slice(6).trim();
          currentListField = null;
        } else if (pTrimmed.startsWith("shell:")) {
          step.shell = pTrimmed.slice(6).trim().replace(/^["']|["']$/g, "");
          currentListField = null;
        } else if (pTrimmed.startsWith("tool:")) {
          step.tool = pTrimmed.slice(5).trim();
          currentListField = null;
        } else if (pTrimmed === "params:") {
          currentListField = "params";
        } else if (pTrimmed === "details:") {
          currentListField = "details";
        } else if (pTrimmed === "refs:") {
          currentListField = "refs";
        } else if (pTrimmed === "input:") {
          currentListField = "input";
        } else if (pTrimmed.startsWith("output:")) {
          step.output = pTrimmed.slice(7).trim();
          currentListField = null;
        } else if (currentListField === "params" && pTrimmed.includes(":") && !pTrimmed.startsWith("- ")) {
          const colonIdx = pTrimmed.indexOf(":");
          const key = pTrimmed.slice(0, colonIdx).trim();
          const val = pTrimmed.slice(colonIdx + 1).trim().replace(/^["']|["']$/g, "");
          step.params[key] = val;
        } else if (pTrimmed.startsWith("- ") && currentListField && currentListField !== "params") {
          step[currentListField].push(pTrimmed.slice(2).trim());
        } else if (!pTrimmed.startsWith("- ")) {
          currentListField = null;
        }

        i++;
      }
    } else {
      i++;
    }
  }

  return steps;
}

// ── flow 섹션 파서 ─────────────────────────────────────────
function parseFlowSection(content) {
  const lines = content.split("\n");
  return parseFlowLines(lines, 0, 0).items;
}

function parseFlowLines(lines, startIdx, baseIndent) {
  const items = [];
  let i = startIdx;

  if (i < lines.length && lines[i].trim() === "flow:") {
    baseIndent = lines[i].search(/\S/) + 2;
    i++;
  }

  while (i < lines.length) {
    const line = lines[i];
    if (line.trim() === "" || line.trim().startsWith("#")) {
      i++;
      continue;
    }

    const indent = line.search(/\S/);
    if (indent < baseIndent && i > startIdx + 1) break;

    const trimmed = line.trim();

    if (trimmed.startsWith("- parallel:")) {
      i++;
      const children = [];
      let childIndent = -1;
      while (i < lines.length) {
        const cLine = lines[i];
        if (cLine.trim() === "" || cLine.trim().startsWith("#")) {
          i++;
          continue;
        }
        const cIndent = cLine.search(/\S/);
        if (childIndent === -1) childIndent = cIndent;
        if (cIndent < childIndent) break;
        const cTrimmed = cLine.trim();

        if (cTrimmed.startsWith("- flow:")) {
          const sub = parseFlowLines(lines, i + 1, cIndent + 4);
          children.push({ type: "flow", items: sub.items });
          i = sub.nextIdx;
        } else if (cTrimmed.startsWith("- ")) {
          const val = cTrimmed.slice(2).trim();
          if (val.endsWith(":")) {
            i++;
          } else {
            children.push({ type: "step", name: val });
            i++;
          }
        } else {
          i++;
        }
      }
      items.push({ type: "parallel", children });
    } else if (trimmed.startsWith("- retry:")) {
      const retryIndent = indent + 4;
      let condition = "";
      let max = 3;
      let retryFlow = [];
      i++;
      while (i < lines.length) {
        const rLine = lines[i];
        if (rLine.trim() === "") {
          i++;
          continue;
        }
        const rIndent = rLine.search(/\S/);
        if (rIndent < retryIndent) break;
        const rTrimmed = rLine.trim();

        if (rTrimmed.startsWith("condition:")) {
          condition = rTrimmed.slice("condition:".length).trim();
          i++;
        } else if (rTrimmed.startsWith("max:")) {
          max = parseInt(rTrimmed.slice("max:".length).trim(), 10);
          i++;
        } else if (rTrimmed === "flow:") {
          const sub = parseFlowLines(lines, i, rIndent);
          retryFlow = sub.items;
          i = sub.nextIdx;
        } else {
          i++;
        }
      }
      items.push({ type: "retry", condition, max, flow: retryFlow });
    } else if (trimmed.startsWith("- if:")) {
      const ifIndent = indent + 4;
      let condition = "";
      let ifFlow = [];
      i++;
      while (i < lines.length) {
        const fLine = lines[i];
        if (fLine.trim() === "") {
          i++;
          continue;
        }
        const fIndent = fLine.search(/\S/);
        if (fIndent < ifIndent) break;
        const fTrimmed = fLine.trim();

        if (fTrimmed.startsWith("condition:")) {
          condition = fTrimmed.slice("condition:".length).trim();
          i++;
        } else if (fTrimmed === "flow:") {
          const sub = parseFlowLines(lines, i, fIndent);
          ifFlow = sub.items;
          i = sub.nextIdx;
        } else {
          i++;
        }
      }
      items.push({ type: "if", condition, flow: ifFlow });
    } else if (trimmed === "- hitl") {
      items.push({ type: "hitl" });
      i++;
    } else if (trimmed.startsWith("- ")) {
      const stepName = trimmed.slice(2).trim();
      items.push({ type: "step", name: stepName });
      i++;
    } else {
      i++;
    }
  }

  return { items, nextIdx: i };
}

// ── 경로 해석 헬퍼 ────────────────────────────────────────
function isPath(val) {
  return val.startsWith("/") || val.startsWith("./") || val.startsWith("../");
}

function resolveRef(ref) {
  return isPath(ref) ? ref : `${AGENT_HOME}/references/${ref}`;
}

function resolveInput(input, outputDir) {
  return isPath(input) ? input : `${outputDir}/${input}.md`;
}

function resolveOutput(output, stepName, outputDir) {
  const file = output || `${stepName}.md`;
  return file.startsWith("/") ? file : `${outputDir}/${file}`;
}

// ── flow를 실행 가능한 Markdown 지시문으로 변환 ─────────────
function flowToMarkdown(items, steps, depth = 0, outputDir = ".local/$ARGUMENTS", registeredAgents = {}) {
  const lines = [];
  let sequenceNum = 1;

  for (const item of items) {
    const prefix = "  ".repeat(depth);

    switch (item.type) {
      case "step": {
        const step = steps[item.name];
        if (!step) {
          lines.push(
            `${prefix}${sequenceNum}. **[STEP]** \`${item.name}\` — ⚠️ 정의되지 않은 step`
          );
        } else if (step.shell) {
          lines.push(`${prefix}${sequenceNum}. **[SHELL]** \`${item.name}\``);
          lines.push(`${prefix}   - desc: ${step.desc}`);
          lines.push(`${prefix}   - command: \`${step.shell}\``);
          lines.push(`${prefix}   - 실행: Bash 도구로 직접 실행한다 (서브에이전트 불필요)`);
        } else if (step.tool) {
          const paramStr = Object.entries(step.params || {})
            .map(([k, v]) => `${k}=\`${v}\``)
            .join(", ");
          lines.push(`${prefix}${sequenceNum}. **[TOOL]** \`${item.name}\``);
          lines.push(`${prefix}   - desc: ${step.desc}`);
          lines.push(`${prefix}   - tool: \`${step.tool}\``);
          if (paramStr) lines.push(`${prefix}   - params: ${paramStr}`);
          lines.push(`${prefix}   - 실행: \`${step.tool}\` 도구를 직접 호출한다 (서브에이전트 불필요)`);
        } else if (!step.agent) {
          // agent 없음 → 오케스트레이터가 직접 수행
          lines.push(`${prefix}${sequenceNum}. **[ORCHESTRATOR]** \`${item.name}\``);
          lines.push(`${prefix}   - desc: ${step.desc}`);
          lines.push(`${prefix}   - 실행: 오케스트레이터가 desc와 details를 기반으로 직접 수행한다 (서브에이전트 불필요)`);
          if (step.details.length > 0) {
            lines.push(
              `${prefix}   - details (필수 준수): ${step.details.map((d) => `\`references/${d}\``).join(", ")}`
            );
          }
          if (step.input.length > 0) {
            lines.push(
              `${prefix}   - input: ${step.input.map((s) => `\`${resolveInput(s, outputDir)}\``).join(", ")}`
            );
          }
        } else {
          const outputFile = resolveOutput(step.output, item.name, outputDir);
          const isReuse = !!registeredAgents[step.agent];
          const resolvedAgent = registeredAgents[step.agent] || step.agent;
          const marker = isReuse ? "[STEP:REUSE]" : "[STEP]";

          lines.push(`${prefix}${sequenceNum}. **${marker}** \`${item.name}\``);
          lines.push(`${prefix}   - desc: ${step.desc}`);
          if (isReuse) {
            lines.push(
              `${prefix}   - agent: \`${step.agent}\` (별칭 → \`${resolvedAgent}\`)`
            );
          } else {
            lines.push(
              `${prefix}   - agent: \`${step.agent}\` → Agent 도구의 subagent_type`
            );
          }
          if (step.details.length > 0) {
            lines.push(
              `${prefix}   - details (필수 준수): ${step.details.map((d) => `\`references/${d}\``).join(", ")} — 에이전트는 이 파일에 정의된 지침을 반드시 따른다`
            );
          }
          if (step.refs.length > 0) {
            lines.push(
              `${prefix}   - refs: ${step.refs.map((r) => `\`${resolveRef(r)}\``).join(", ")}`
            );
          }
          if (step.input.length > 0) {
            lines.push(
              `${prefix}   - input: ${step.input.map((s) => `\`${resolveInput(s, outputDir)}\``).join(", ")}`
            );
          }
          lines.push(`${prefix}   - 산출물: \`${outputFile}\``);
        }
        sequenceNum++;
        break;
      }

      case "parallel": {
        lines.push(
          `${prefix}${sequenceNum}. **[PARALLEL]** 다음 ${item.children.length}개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):`
        );
        for (const child of item.children) {
          if (child.type === "step") {
            const step = steps[child.name];
            if (step) {
              const brief =
                step.desc.length > 50
                  ? step.desc.slice(0, 50) + "..."
                  : step.desc;
              lines.push(
                `${prefix}   - \`${child.name}\`: ${brief} (agent: \`${step.agent}\`)`
              );
            } else {
              lines.push(
                `${prefix}   - \`${child.name}\`: ⚠️ 정의되지 않은 step`
              );
            }
          } else if (child.type === "flow") {
            lines.push(`${prefix}   - (순차 흐름):`);
            const subLines = flowToMarkdown(child.items, steps, depth + 2, outputDir, registeredAgents);
            lines.push(subLines);
          }
        }
        sequenceNum++;
        break;
      }

      case "retry": {
        lines.push(
          `${prefix}${sequenceNum}. **[RETRY]** 조건: \`${item.condition}\`, 최대: ${item.max}회`
        );
        lines.push(`${prefix}   반복 내부 흐름:`);
        const retryLines = flowToMarkdown(item.flow, steps, depth + 2, outputDir, registeredAgents);
        lines.push(retryLines);
        lines.push(
          `${prefix}   → 내부 흐름 실행 후 조건(\`${item.condition}\`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 ${item.max}회.`
        );
        sequenceNum++;
        break;
      }

      case "if": {
        lines.push(
          `${prefix}${sequenceNum}. **[IF]** 조건: \`${item.condition}\``
        );
        lines.push(`${prefix}   조건이 true일 때 실행:`);
        const ifLines = flowToMarkdown(item.flow, steps, depth + 2, outputDir, registeredAgents);
        lines.push(ifLines);
        sequenceNum++;
        break;
      }

      case "hitl": {
        lines.push(
          `${prefix}${sequenceNum}. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.`
        );
        lines.push(`${prefix}   - 승인 → 다음 단계로 진행`);
        lines.push(`${prefix}   - 피드백 → 이전 단계를 피드백과 함께 재실행`);
        sequenceNum++;
        break;
      }
    }

    lines.push("");
  }

  return lines.join("\n");
}

// ── 스킬 Markdown 생성 ────────────────────────────────────
function generateSkillMd(name, parsed) {
  const { agents, steps, flowItems, inputs, outputDir, raw } = parsed;

  const stepTable = Object.entries(steps)
    .map(([stepName, { agent, shell, tool, desc }]) => {
      const brief = desc.length > 60 ? desc.slice(0, 60) + "..." : desc;
      let type;
      if (shell) type = "[shell]";
      else if (tool) type = `[tool: ${tool}]`;
      else if (!agent) type = "[orchestrator]";
      else if (agents[agent]) type = `${agent} → ${agents[agent]}`;
      else type = agent;
      return `| ${stepName} | ${type} | ${brief} |`;
    })
    .join("\n");

  // 검증: 스코프 체인에서 details 탐색
  const warnings = [];
  for (const [stepName, { agent, shell, tool, refs, details }] of Object.entries(steps)) {
    const resolvedAgent = agents[agent] || agent;
    if (!shell && !tool && agent && !AGENTS_BUILD_DIRS.some(d => fs.existsSync(path.join(d, `${resolvedAgent}.md`)))) {
      warnings.push(
        `- ${stepName}: agent \`${resolvedAgent}\` not found in agents directories`
      );
    }
    for (const ref of refs) {
      if (isPath(ref)) continue;
      if (!fs.existsSync(path.join(REFERENCES_DIR, ref))) {
        warnings.push(
          `- ${stepName}: ref \`${ref}\` not found in \`${REFERENCES_DIR}/\``
        );
      }
    }
    for (const det of details) {
      if (!resolveDetail(det)) {
        warnings.push(
          `- ${stepName}: details \`${det}\` not found in any scope`
        );
      }
    }
  }

  const warningSection =
    warnings.length > 0
      ? `\n> **검증 경고:**\n${warnings.map((w) => `> ${w}`).join("\n")}\n`
      : "";

  const flowInstructions = flowToMarkdown(flowItems, steps, 0, outputDir, agents);

  // input 파라미터 섹션
  const inputEntries = Object.entries(inputs);
  const inputSection = inputEntries.length > 0
    ? `## 입력 파라미터

워크플로우 실행 시 \`$ARGUMENTS\`에서 다음 플래그를 파싱한다:

| 플래그 | 설명 | 기본값 |
|--------|------|--------|
${inputEntries.map(([flag, { desc, default: def }]) => `| \`--${flag}\` | ${desc || "-"} | \`${def || ""}\` |`).join("\n")}

인자 파싱 규칙:
- \`--{flag} {value}\` 형태로 전달된 값을 추출한다
- 플래그가 없으면 기본값을 사용한다
- 플래그가 아닌 나머지 인자는 \`$ARGUMENTS\`로 사용한다

`
    : "";

  // 재활용 에이전트 테이블
  const agentEntries = Object.entries(agents);
  let agentsSection = "";
  if (agentEntries.length > 0) {
    // 각 별칭이 어떤 스텝에서 사용되는지 수집
    const aliasUsage = {};
    for (const [alias] of agentEntries) aliasUsage[alias] = [];
    for (const [stepName, { agent }] of Object.entries(steps)) {
      if (agents[agent]) aliasUsage[agent].push(stepName);
    }
    const agentRows = agentEntries
      .map(([alias, agentName]) => `| ${alias} | ${agentName} | ${aliasUsage[alias].join(", ") || "-"} |`)
      .join("\n");
    agentsSection = `## 재활용 에이전트

| 별칭 | 베이스 에이전트 | 사용 스텝 |
|------|----------------|----------|
${agentRows}

`;
  }

  // [STEP:REUSE] 규칙
  const reuseRule = agentEntries.length > 0
    ? `- **[STEP:REUSE]**는 \`define.agents\`에 등록된 별칭 에이전트다. 동일 별칭의 첫 호출 시 Agent 도구로 생성하고, 이후 호출은 SendMessage로 기존 에이전트에 전달하여 컨텍스트를 유지한다. 별칭별로 에이전트 ID를 추적한다.
`
    : "";

  return `---
name: ${name}
description: Workflow: ${name}
---

# Workflow: ${name}

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
${warningSection}
${inputSection}## 산출물 디렉토리

\`${outputDir}\`

${agentsSection}## Steps

| Step | Agent | Description |
|------|-------|-------------|
${stepTable}

## 실행 규칙

- 각 **[STEP]**은 Agent 도구로 서브에이전트를 실행한다. 프롬프트는 **반드시 아래 순서**로 구성하여 실행계획 캐싱을 극대화한다:
  1. agent 파일: \`${AGENT_HOME}/agents/{agent}.md\`를 읽어 프롬프트에 포함
  2. desc를 task 설명으로 서브에이전트에 전달
  3. details 파일들(\`references/\`)은 **반드시 준수해야 할 지침**이다. 에이전트 프롬프트에 포함하고 "이 details 파일의 지침을 반드시 따르라"고 명시한다
  4. refs 파일들(\`${AGENT_HOME}/references/\`)을 컨텍스트로 서브에이전트에 제공
  5. \`$STEP_NAME\`으로 step 이름을 전달하여 산출물 파일명을 결정
  6. input step들의 산출물을 입력으로 전달 — **가장 마지막에 배치** (retry 시 이 부분만 변경됨)
${reuseRule}- **[ORCHESTRATOR]**는 agent 없이 오케스트레이터가 desc와 details를 기반으로 직접 수행한다.
- **[SHELL]**은 Bash 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[TOOL]**은 명시된 Claude 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[PARALLEL]**은 하나의 메시지에 여러 Agent 호출을 포함하여 동시 실행한다.
- **[RETRY]**는 내부 흐름 실행 후 조건을 평가한다. score는 review step 산출물에서 추출한다.
- **[HITL]**에서 사용자가 피드백을 주면, 직전 단계를 피드백과 함께 재실행한다.
- 산출물은 \`${outputDir}/\` 디렉토리에 파일로 저장한다. 메인 컨텍스트에 산출물 내용을 넣지 않는다.
- 워크플로우 시작 시 해당 디렉토리를 미리 생성한다 (mkdir -p).
- 서브에이전트 완료 후 산출물 파일 경로만 사용자에게 보고한다.

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

${flowInstructions}

## 원본 정의

\`\`\`yaml
${raw.trim()}
\`\`\`
`;
}

// ── 스킬 디렉토리 삭제 ─────────────────────────────────────
function removeSkillDir(name, skillsDir) {
  const skillPath = path.join(skillsDir, name);
  if (!fs.existsSync(skillPath)) return false;
  fs.rmSync(skillPath, { recursive: true, force: true });
  return true;
}

// ── 빌드 ──────────────────────────────────────────────────
function buildWorkflow(templateFile, skillsDir) {
  const name = path.basename(templateFile, path.extname(templateFile));
  const parsed = parseWorkflowYaml(templateFile);

  if (Object.keys(parsed.steps).length === 0) {
    throw new Error("step 정의를 찾을 수 없습니다");
  }

  const skillOutDir = path.join(skillsDir, name);
  const refsOutDir = path.join(skillOutDir, "references");

  fs.mkdirSync(skillOutDir, { recursive: true });

  // details 파일을 스코프 체인에서 탐색하여 복사
  const allDetails = new Set(
    Object.values(parsed.steps).flatMap((s) => s.details)
  );
  if (allDetails.size > 0) {
    fs.mkdirSync(refsOutDir, { recursive: true });
    for (const det of allDetails) {
      const src = resolveDetail(det);
      const dst = path.join(refsOutDir, det);
      if (src) {
        fs.copyFileSync(src, dst);
      }
    }
  }

  const md = generateSkillMd(name, parsed);
  fs.writeFileSync(path.join(skillOutDir, "SKILL.md"), md, "utf-8");

  // step별 details 매핑 (매니페스트용)
  const stepDetails = {};
  for (const [stepName, step] of Object.entries(parsed.steps)) {
    if (step.details.length > 0) {
      stepDetails[stepName] = step.details;
    }
  }

  return { name, stepCount: Object.keys(parsed.steps).length, detailCount: allDetails.size, stepDetails };
}

// ── 스코프별 템플릿 수집 ──────────────────────────────────
function collectTemplates() {
  const seen = new Set();
  const result = [];

  for (const scope of SCOPES) {
    const templateDir = path.join(scope.srcDir, "templates");
    if (!fs.existsSync(templateDir)) continue;

    const files = fs.readdirSync(templateDir).filter((f) => f.endsWith(".yaml") || f.endsWith(".yml"));
    for (const file of files) {
      if (seen.has(file)) continue;
      seen.add(file);
      result.push({ file: path.join(templateDir, file), scope });
    }
  }

  return result;
}

// ── 전체 빌드 ─────────────────────────────────────────────
function buildAll() {
  const templates = collectTemplates();

  if (templates.length === 0) {
    console.log("No workflow templates.");
    return;
  }

  console.log(`\n🔨 Workflow 빌드 시작 (${templates.length}개)\n`);

  // 인덱스별로 이전 빌드물 추적
  const indexFiles = [...new Set(SCOPES.map((s) => s.indexFile))];
  const prevIndexes = {};
  for (const f of indexFiles) {
    prevIndexes[f] = loadBuildIndex(f);
  }

  const nowGenerated = {};
  for (const f of indexFiles) {
    nowGenerated[f] = new Set();
  }

  let success = 0;
  let failed = 0;
  const manifest = {};

  for (const { file, scope } of templates) {
    const fileName = path.basename(file, path.extname(file));
    try {
      const { name, stepCount, detailCount, stepDetails } = buildWorkflow(file, scope.outputDir);
      nowGenerated[scope.indexFile].add(name);
      if (Object.keys(stepDetails).length > 0) {
        manifest[name] = stepDetails;
      }
      const detailNote = detailCount > 0 ? `, ${detailCount} details` : "";
      console.log(`  ✓ [${scope.name}] ${name} (${stepCount} steps${detailNote})`);
      success++;
    } catch (err) {
      console.error(`  ✗ [${scope.name}] ${fileName}: ${err.message}`);
      failed++;
    }
  }

  // 삭제된 템플릿에 대응하는 스킬 디렉토리 정리 + 인덱스 갱신
  let removed = 0;
  for (const f of indexFiles) {
    const prev = new Set(prevIndexes[f].generated);
    const now = nowGenerated[f];
    const scope = SCOPES.find((s) => s.indexFile === f);

    for (const name of prev) {
      if (now.has(name)) continue;
      if (removeSkillDir(name, scope.outputDir)) {
        console.log(`  ✗ removed: ${name}/`);
        removed++;
      }
    }

    saveBuildIndex(f, { generated: [...now].sort() });
  }

  // 매니페스트 생성
  if (Object.keys(manifest).length > 0) {
    fs.mkdirSync(path.dirname(MANIFEST_PATH), { recursive: true });
    fs.writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2) + "\n", "utf-8");
    console.log(`  📋 manifest: ${MANIFEST_PATH}`);
  }

  console.log(`\n완료: ${success}개 성공, ${failed}개 실패, ${removed}개 삭제\n`);
}

// ── watch 모드 ────────────────────────────────────────────
function watchMode() {
  buildAll();
  console.log("👀 파일 변경 감지 중... (Ctrl+C로 종료)\n");

  for (const scope of SCOPES) {
    if (!fs.existsSync(scope.srcDir)) continue;
    fs.watch(scope.srcDir, { recursive: true }, (_, filename) => {
      if (filename?.endsWith(".yaml") || filename?.endsWith(".yml") || filename?.endsWith(".md")) {
        console.log(`\n변경 감지 [${scope.name}]: ${filename}`);
        buildAll();
      }
    });
  }
}

// ── clean 모드 ────────────────────────────────────────────
function cleanOnly() {
  const indexFiles = [...new Set(SCOPES.map((s) => s.indexFile))];
  let totalRemoved = 0;

  for (const f of indexFiles) {
    const index = loadBuildIndex(f);
    if (index.generated.length === 0) continue;

    const scope = SCOPES.find((s) => s.indexFile === f);

    for (const name of index.generated) {
      if (removeSkillDir(name, scope.outputDir)) {
        console.log(`  ✗ removed: ${name}/`);
        totalRemoved++;
      }
    }

    saveBuildIndex(f, { generated: [] });
  }

  // 매니페스트 삭제
  if (fs.existsSync(MANIFEST_PATH)) {
    fs.unlinkSync(MANIFEST_PATH);
    console.log("  ✗ removed: .workflow-details-manifest.local.json");
    totalRemoved++;
  }

  if (totalRemoved === 0) {
    console.log("삭제할 파일 없음.");
  } else {
    console.log(`\n완료: ${totalRemoved}개 삭제\n`);
  }
}

// ── 진입점 ────────────────────────────────────────────────
const args = process.argv.slice(2);
if (args.includes("--clean")) {
  cleanOnly();
} else if (args.includes("--watch")) {
  watchMode();
} else {
  buildAll();
}
