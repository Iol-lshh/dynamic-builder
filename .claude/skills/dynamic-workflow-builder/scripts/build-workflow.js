#!/usr/bin/env node
/**
 * Workflow 빌드 스크립트
 *
 * templates/*.yaml 워크플로우 정의를 읽어
 * ~/.claude/skills/{name}/ 에 SKILL.md + references/ 를 생성한다.
 *
 * 사용법:
 *   node build-workflow.js
 *   node build-workflow.js --watch
 *   node build-workflow.js --clean
 *
 * 입력:
 *   skills/dynamic-workflow-builder/src/templates/*.yaml
 *   skills/dynamic-workflow-builder/src/details/*.md
 *
 * 출력:
 *   skills/{name}/SKILL.md
 *   skills/{name}/references/{detail}.md
 */

const fs = require("fs");
const path = require("path");

// ── 경로 설정 ──────────────────────────────────────────────
const SKILL_DIR = path.resolve(__dirname, "..");
const CLAUDE_DIR = path.resolve(SKILL_DIR, "..", "..");
const SRC_DIR = path.join(SKILL_DIR, "src");
const TEMPLATE_DIR = path.join(SRC_DIR, "templates");
const DETAILS_DIR = path.join(SRC_DIR, "details");
const SKILLS_DIR = path.join(CLAUDE_DIR, "skills");
const AGENTS_BUILD_DIR = path.join(CLAUDE_DIR, "agents");
const REFERENCES_DIR = path.join(CLAUDE_DIR, "references");
const BUILD_INDEX_FILE = path.join(SKILL_DIR, ".build-index.local.json");

// ── 빌드 인덱스 ────────────────────────────────────────────
function loadBuildIndex() {
  if (!fs.existsSync(BUILD_INDEX_FILE)) return { generated: [] };
  try {
    return JSON.parse(fs.readFileSync(BUILD_INDEX_FILE, "utf-8"));
  } catch {
    return { generated: [] };
  }
}

function saveBuildIndex(index) {
  fs.writeFileSync(BUILD_INDEX_FILE, JSON.stringify(index, null, 2) + "\n", "utf-8");
}

// ── YAML 파싱 ──────────────────────────────────────────────
function parseWorkflowYaml(filePath) {
  const content = fs.readFileSync(filePath, "utf-8");
  const steps = parseSteps(content);

  // output-dir 파싱
  const outputDirMatch = content.match(/^output-dir:\s*(.+)$/m);
  const outputDir = outputDirMatch ? outputDirMatch[1].trim() : ".local/$ARGUMENTS";

  // flow 섹션 원문 추출
  const flowStart = content.indexOf("\nflow:");
  const flowContent = flowStart >= 0 ? content.slice(flowStart) : "";

  // flow를 구조화된 배열로 파싱
  const flowItems = flowStart >= 0 ? parseFlowSection(flowContent) : [];

  return { steps, flowItems, outputDir, raw: content };
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

    // 스텝 선언: "    - step-name:"
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
  return isPath(ref) ? ref : `~/.claude/references/${ref}`;
}

function resolveInput(input, outputDir) {
  return isPath(input) ? input : `${outputDir}/${input}.md`;
}

function resolveOutput(output, stepName, outputDir) {
  const file = output || `${stepName}.md`;
  return file.startsWith("/") ? file : `${outputDir}/${file}`;
}

// ── flow를 실행 가능한 Markdown 지시문으로 변환 ─────────────
function flowToMarkdown(items, steps, depth = 0, outputDir = ".local/$ARGUMENTS") {
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
        } else {
          const outputFile = resolveOutput(step.output, item.name, outputDir);
          lines.push(`${prefix}${sequenceNum}. **[STEP]** \`${item.name}\``);
          lines.push(`${prefix}   - desc: ${step.desc}`);
          lines.push(
            `${prefix}   - agent: \`${step.agent}\` → Agent 도구의 subagent_type`
          );
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
            const subLines = flowToMarkdown(child.items, steps, depth + 2, outputDir);
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
        const retryLines = flowToMarkdown(item.flow, steps, depth + 2, outputDir);
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
        const ifLines = flowToMarkdown(item.flow, steps, depth + 2, outputDir);
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
  const { steps, flowItems, outputDir, raw } = parsed;

  const stepTable = Object.entries(steps)
    .map(([stepName, { agent, shell, tool, desc }]) => {
      const brief = desc.length > 60 ? desc.slice(0, 60) + "..." : desc;
      const type = shell ? "[shell]" : tool ? `[tool: ${tool}]` : agent;
      return `| ${stepName} | ${type} | ${brief} |`;
    })
    .join("\n");

  // 검증
  const warnings = [];
  for (const [stepName, { agent, shell, tool, refs, details }] of Object.entries(steps)) {
    if (!shell && !tool && !fs.existsSync(path.join(AGENTS_BUILD_DIR, `${agent}.md`))) {
      warnings.push(
        `- ${stepName}: agent \`${agent}\` not found in \`${AGENTS_BUILD_DIR}/\``
      );
    }
    for (const ref of refs) {
      if (isPath(ref)) continue; // 경로 기반은 런타임에 해석
      if (!fs.existsSync(path.join(REFERENCES_DIR, ref))) {
        warnings.push(
          `- ${stepName}: ref \`${ref}\` not found in \`${REFERENCES_DIR}/\``
        );
      }
    }
    for (const det of details) {
      if (!fs.existsSync(path.join(DETAILS_DIR, det))) {
        warnings.push(
          `- ${stepName}: details \`${det}\` not found in \`${DETAILS_DIR}/\``
        );
      }
    }
  }

  const warningSection =
    warnings.length > 0
      ? `\n> **검증 경고:**\n${warnings.map((w) => `> ${w}`).join("\n")}\n`
      : "";

  const flowInstructions = flowToMarkdown(flowItems, steps, 0, outputDir);

  return `---
name: ${name}
description: Workflow: ${name}
---

# Workflow: ${name}

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: \`~/.claude/skills/dynamic-workflow-builder/src/templates/${name}.yaml\`
${warningSection}
## 산출물 디렉토리

\`${outputDir}\`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
${stepTable}

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

${flowInstructions}

## 실행 규칙

- 각 **[STEP]**은 Agent 도구로 서브에이전트를 실행한다.
  - agent 파일: \`~/.claude/agents/{agent}.md\`를 읽어 프롬프트에 포함
  - desc를 task 설명으로 서브에이전트에 전달
  - refs 파일들(\`~/.claude/references/\`)을 컨텍스트로 서브에이전트에 제공
  - details 파일들(\`references/\`)은 **반드시 준수해야 할 지침**이다. 에이전트 프롬프트에 포함하고 "이 details 파일의 지침을 반드시 따르라"고 명시한다
  - input step들의 산출물을 입력으로 전달
  - \`$STEP_NAME\`으로 step 이름을 전달하여 산출물 파일명을 결정
- **[SHELL]**은 Bash 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[TOOL]**은 명시된 Claude 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[PARALLEL]**은 하나의 메시지에 여러 Agent 호출을 포함하여 동시 실행한다.
- **[RETRY]**는 내부 흐름 실행 후 조건을 평가한다. score는 review step 산출물에서 추출한다.
- **[HITL]**에서 사용자가 피드백을 주면, 직전 단계를 피드백과 함께 재실행한다.
- 산출물은 \`${outputDir}/\` 디렉토리에 파일로 저장한다. 메인 컨텍스트에 산출물 내용을 넣지 않는다.
- 워크플로우 시작 시 해당 디렉토리를 미리 생성한다 (mkdir -p).
- 서브에이전트 완료 후 산출물 파일 경로만 사용자에게 보고한다.

## 원본 정의

\`\`\`yaml
${raw.trim()}
\`\`\`
`;
}

// ── 스킬 디렉토리 삭제 ─────────────────────────────────────
function removeSkillDir(name) {
  const skillPath = path.join(SKILLS_DIR, name);
  if (!fs.existsSync(skillPath)) return false;
  fs.rmSync(skillPath, { recursive: true, force: true });
  return true;
}

// ── 빌드 ──────────────────────────────────────────────────
function buildWorkflow(templateFile) {
  const name = path.basename(templateFile, ".yaml");
  const parsed = parseWorkflowYaml(templateFile);

  if (Object.keys(parsed.steps).length === 0) {
    throw new Error("step 정의를 찾을 수 없습니다");
  }

  const skillOutDir = path.join(SKILLS_DIR, name);
  const refsOutDir = path.join(skillOutDir, "references");

  fs.mkdirSync(skillOutDir, { recursive: true });

  // details 파일이 있을 때만 references/ 생성
  const allDetails = new Set(
    Object.values(parsed.steps).flatMap((s) => s.details)
  );
  if (allDetails.size > 0) {
    fs.mkdirSync(refsOutDir, { recursive: true });
    for (const det of allDetails) {
      const src = path.join(DETAILS_DIR, det);
      const dst = path.join(refsOutDir, det);
      if (fs.existsSync(src)) {
        fs.copyFileSync(src, dst);
      }
    }
  }

  const md = generateSkillMd(name, parsed);
  fs.writeFileSync(path.join(skillOutDir, "SKILL.md"), md, "utf-8");

  const actionNote = allDetails.size > 0 ? `, ${allDetails.size} details` : "";
  console.log(
    `  ${name} → skills/${name}/SKILL.md (${Object.keys(parsed.steps).length} steps${actionNote})`
  );
}

function buildAll() {
  if (!fs.existsSync(TEMPLATE_DIR)) {
    console.error(`template directory: ${TEMPLATE_DIR}`);
    process.exit(1);
  }

  const files = fs
    .readdirSync(TEMPLATE_DIR)
    .filter((f) => f.endsWith(".yaml") || f.endsWith(".yml"));

  if (files.length === 0) {
    console.log("No workflow templates.");
    return;
  }

  console.log(`\nWorkflow build (${files.length})\n`);

  const index = loadBuildIndex();
  const previouslyGenerated = new Set(index.generated);
  const nowGenerated = new Set();

  let success = 0;
  let failed = 0;

  for (const file of files) {
    const name = path.basename(file, path.extname(file));
    try {
      buildWorkflow(path.join(TEMPLATE_DIR, file));
      nowGenerated.add(name);
      success++;
    } catch (err) {
      console.error(`  ${file}: ${err.message}`);
      failed++;
    }
  }

  // 인덱스에 있지만 현재 템플릿에 없는 스킬 디렉토리 삭제
  let removed = 0;
  for (const name of previouslyGenerated) {
    if (nowGenerated.has(name)) continue;
    if (removeSkillDir(name)) {
      console.log(`  removed: skills/${name}/`);
      removed++;
    }
  }

  saveBuildIndex({ generated: [...nowGenerated].sort() });

  console.log(`\nDone: ${success} ok, ${failed} fail, ${removed} removed\n`);
}

// ── watch 모드 ────────────────────────────────────────────
function watchMode() {
  buildAll();
  console.log("Watching... (Ctrl+C)\n");

  if (fs.existsSync(TEMPLATE_DIR)) {
    fs.watch(TEMPLATE_DIR, { recursive: true }, (_, filename) => {
      if (filename?.endsWith(".yaml") || filename?.endsWith(".yml")) {
        console.log(`\nChanged: ${filename}`);
        buildAll();
      }
    });
  }
}

// ── clean 모드 ────────────────────────────────────────────
function cleanOnly() {
  const index = loadBuildIndex();
  if (index.generated.length === 0) {
    console.log("인덱스가 비어있습니다. 삭제할 파일 없음.");
    return;
  }

  let removed = 0;
  for (const name of index.generated) {
    if (removeSkillDir(name)) {
      console.log(`  removed: skills/${name}/`);
      removed++;
    }
  }

  saveBuildIndex({ generated: [] });
  console.log(`\nDone: ${removed} removed\n`);
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
