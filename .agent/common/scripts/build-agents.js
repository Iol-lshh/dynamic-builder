#!/usr/bin/env node
/**
 * Agent 빌드 스크립트 (3-tier scope chain)
 *
 * 3단계 스코프 체인으로 소스를 해석하여 agent를 빌드한다:
 *   project (.dynamic-builder/build-agent/src/)  ← 최우선
 *   global  (~/.dynamic-builder/build-agent/src/)
 *   default (플러그인 내부 src/)
 *
 * 부품(perspectives, roles, principles)은 스코프 순서로 오버라이드.
 * 템플릿은 스코프별로 수집하되, 상위 스코프가 같은 이름을 가리면 하위는 스킵.
 * 빌드 출력 위치는 템플릿의 소스 스코프에 따라 결정:
 *   project 템플릿 → {project}/{AGENT_HOME_NAME}/agents/
 *   global/default 템플릿 → $AGENT_HOME/agents/
 *
 * 사용법:
 *   node build-agents.js
 *   node build-agents.js --watch
 *   node build-agents.js --clean
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
const SKILL_DIR = path.join(PLUGIN_DIR, "skills/build-agent");
const AGENT_DIR = AGENT_HOME;
const DYNAMIC_BUILDER_DIR = path.join(os.homedir(), ".dynamic-builder");
const PROJECT_ROOT = findProjectRoot();

// 스코프 정의 (읽기 + 쓰기)
const SCOPES = [
  PROJECT_ROOT && {
    name: "project",
    srcDir: path.join(PROJECT_ROOT, ".dynamic-builder/build-agent/src"),
    outputDir: path.join(PROJECT_ROOT, path.basename(AGENT_HOME), "agents"),
    indexFile: path.join(PROJECT_ROOT, ".dynamic-builder/build-agent/.build-index.local.json"),
  },
  {
    name: "global",
    srcDir: path.join(DYNAMIC_BUILDER_DIR, "build-agent/src"),
    outputDir: path.join(AGENT_DIR, "agents"),
    indexFile: path.join(DYNAMIC_BUILDER_DIR, "build-agent/.build-index.local.json"),
  },
  {
    name: "default",
    srcDir: path.join(SKILL_DIR, "src"),
    outputDir: path.join(AGENT_DIR, "agents"),
    indexFile: path.join(DYNAMIC_BUILDER_DIR, "build-agent/.build-index.local.json"),
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

// ── 유틸 ──────────────────────────────────────────────────
function readFile(filePath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`파일을 찾을 수 없습니다: ${filePath}`);
  }
  return fs.readFileSync(filePath, "utf-8").trim();
}

function parseFrontmatterBlock(raw) {
  const meta = {};
  for (const line of raw.split("\n")) {
    const [key, ...rest] = line.split(":");
    if (key && rest.length) {
      const value = rest.join(":").trim();
      if (value.startsWith("[") && value.endsWith("]")) {
        meta[key.trim()] = value
          .slice(1, -1)
          .split(",")
          .map((v) => v.trim());
      } else {
        meta[key.trim()] = value;
      }
    }
  }
  return meta;
}

function parseFrontmatter(content) {
  // 상단 frontmatter
  const topMatch = content.match(/^---\n([\s\S]*?)\n---\n?([\s\S]*)$/);
  if (topMatch) {
    return { meta: parseFrontmatterBlock(topMatch[1]), body: topMatch[2].trim() };
  }
  // 하단 frontmatter
  const bottomMatch = content.match(/^([\s\S]*?)\n---\n([\s\S]*?)\n---\s*$/);
  if (bottomMatch) {
    return { meta: parseFrontmatterBlock(bottomMatch[2]), body: bottomMatch[1].trim() };
  }
  return { meta: {}, body: content };
}

// ── 부품 해석: 스코프 체인으로 탐색 ──────────────────────────
function resolveComponent(category, name) {
  for (const scope of SCOPES) {
    const filePath = path.join(scope.srcDir, category, `${name}.md`);
    if (fs.existsSync(filePath)) return filePath;
  }
  throw new Error(`부품을 찾을 수 없습니다: ${category}/${name}.md`);
}

// ── 부품 내용 읽기 (frontmatter 제거) ────────────────────────
function readComponentBody(category, name) {
  const content = readFile(resolveComponent(category, name));
  const { body } = parseFrontmatter(content);
  return body;
}

// ── XML 태그에 내용 주입 ───────────────────────────────────
function injectTags(body) {
  body = body.replace(
    /<Perspective name="([^"]+)"><\/Perspective>/g,
    (_, name) => {
      const content = readComponentBody("perspectives", name);
      return `<Perspective name="${name}">\n${content}\n</Perspective>`;
    }
  );

  body = body.replace(
    /<Principle name="([^"]+)"><\/Principle>/g,
    (_, name) => {
      const content = readComponentBody("principles", name);
      return `<Principle name="${name}">\n${content}\n</Principle>`;
    }
  );

  body = body.replace(/<Role name="([^"]+)"><\/Role>/g, (_, name) => {
    const content = readComponentBody("roles", name);
    return `<Role name="${name}">\n${content}\n</Role>`;
  });

  return body;
}

// ── 빌드 결과물 순서 역전 (캐싱 최적화) ──────────────────────
function reorderForCaching(body) {
  // <Agent> 블록 내부에서 Perspective, Role, Principle 태그를 추출하여
  // Principles → Perspective → Role 순서로 재배치한다.
  // <Agent> 바깥의 추가 콘텐츠(예: 실행 절차)는 그대로 유지한다.

  const agentMatch = body.match(/<Agent>([\s\S]*?)<\/Agent>/);
  if (!agentMatch) return body;

  const agentInner = agentMatch[1];
  const afterAgent = body.substring(agentMatch.index + agentMatch[0].length).trim();

  // Perspective 추출
  const perspMatch = agentInner.match(/(\s*<Perspective name="[^"]+">[\s\S]*?<\/Perspective>)/);
  const perspBlock = perspMatch ? perspMatch[1] : "";

  // Role 추출
  const roleMatch = agentInner.match(/(\s*<Role name="[^"]+">[\s\S]*?<\/Role>)/);
  const roleBlock = roleMatch ? roleMatch[1] : "";

  // Principle 블록들 추출 (개별 태그)
  const principleBlocks = [];
  const principleRegex = /\s*<Principle name="[^"]+">[\s\S]*?<\/Principle>/g;

  // <Principles> wrapper가 있으면 그 안에서 추출
  const principlesWrapperMatch = agentInner.match(/<Principles>([\s\S]*?)<\/Principles>/);
  const searchIn = principlesWrapperMatch ? principlesWrapperMatch[1] : agentInner;

  let m;
  while ((m = principleRegex.exec(searchIn)) !== null) {
    principleBlocks.push(m[0]);
  }

  // 재조립: Principles → Perspective → Role
  let newInner = "";
  if (principleBlocks.length > 0) {
    newInner += "\n  <Principles>";
    for (const p of principleBlocks) {
      newInner += "\n  " + p.trim();
    }
    newInner += "\n  </Principles>";
  }
  if (perspBlock) newInner += "\n" + perspBlock;
  if (roleBlock) newInner += "\n" + roleBlock;

  let result = `<Agent>${newInner}\n</Agent>`;
  if (afterAgent) result += "\n\n" + afterAgent;

  return result;
}

// ── Role frontmatter 캐시 ─────────────────────────────────
const roleMetaCache = {};

function getRoleMeta(roleName) {
  if (roleMetaCache[roleName]) return roleMetaCache[roleName];

  try {
    const rolePath = resolveComponent("roles", roleName);
    const { meta } = parseFrontmatter(readFile(rolePath));
    roleMetaCache[roleName] = meta;
    return meta;
  } catch {
    return {};
  }
}

function extractRoleName(body) {
  const match = body.match(/<Role name="([^"]+)">/);
  return match ? match[1] : null;
}

// ── 핵심: 병합 (role default → template override) ─────────
function buildAgent(templateFile, outputDir) {
  const templateName = path.basename(templateFile, ".md");
  const templateContent = readFile(templateFile);
  const { meta: templateMeta, body } = parseFrontmatter(templateContent);

  const roleName = extractRoleName(body);
  const roleMeta = roleName ? getRoleMeta(roleName) : {};

  const merged = { ...roleMeta, ...templateMeta };

  const agentName = merged.name || templateName;
  const description = merged.description || "";
  const model = merged.model || "sonnet";
  const effort = merged.effort;
  const maxTokens = merged.maxTokens;
  const disallowedTools = merged.disallowedTools || [];

  const lines = [
    `name: ${agentName}`,
    `description: ${description}`,
    `model: ${model}`,
  ];
  if (effort) lines.push(`effort: ${effort}`);
  if (maxTokens) lines.push(`maxTokens: ${maxTokens}`);
  if (disallowedTools.length > 0)
    lines.push(`disallowedTools: [${disallowedTools.join(", ")}]`);

  const injectedBody = injectTags(body);

  // 빌드 결과물 순서 역전: Principles → Perspective → Role (캐싱 최적화)
  const reorderedBody = reorderForCaching(injectedBody);

  const output = `${reorderedBody}\n---\n${lines.join("\n")}\n---`.trim();

  fs.mkdirSync(outputDir, { recursive: true });

  const outFile = path.join(outputDir, `${agentName}.md`);
  fs.writeFileSync(outFile, output, "utf-8");

  return agentName;
}

// ── 스코프별 템플릿 수집 ──────────────────────────────────
function collectTemplates() {
  const seen = new Set();
  const result = []; // { file, scope }

  for (const scope of SCOPES) {
    const templateDir = path.join(scope.srcDir, "templates");
    if (!fs.existsSync(templateDir)) continue;

    const files = fs.readdirSync(templateDir).filter((f) => f.endsWith(".md"));
    for (const file of files) {
      if (seen.has(file)) continue; // 상위 스코프가 우선
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
    console.log("빌드할 템플릿 파일이 없습니다.");
    return;
  }

  console.log(`\n🔨 Agent 빌드 시작 (${templates.length}개)\n`);

  // 인덱스별로 이전 빌드물 추적
  const indexFiles = [...new Set(SCOPES.map((s) => s.indexFile))];
  const prevIndexes = {};
  for (const f of indexFiles) {
    prevIndexes[f] = loadBuildIndex(f);
  }

  // 스코프별 생성 결과 추적
  const nowGenerated = {}; // indexFile → Set<filename>
  for (const f of indexFiles) {
    nowGenerated[f] = new Set();
  }

  let success = 0;
  let failed = 0;

  for (const { file, scope } of templates) {
    const name = path.basename(file, ".md");
    try {
      const agentName = buildAgent(file, scope.outputDir);
      nowGenerated[scope.indexFile].add(`${agentName}.md`);
      console.log(`  ✓ [${scope.name}] ${agentName}`);
      success++;
    } catch (err) {
      console.error(`  ✗ [${scope.name}] ${name}: ${err.message}`);
      failed++;
    }
  }

  // 삭제된 템플릿에 대응하는 파일 정리 + 인덱스 갱신
  let removed = 0;
  for (const f of indexFiles) {
    const prev = new Set(prevIndexes[f].generated);
    const now = nowGenerated[f];
    // 이 인덱스에 연결된 outputDir 찾기
    const scope = SCOPES.find((s) => s.indexFile === f);
    const outputDir = scope.outputDir;

    for (const agentFile of prev) {
      if (now.has(agentFile)) continue;
      const filePath = path.join(outputDir, agentFile);
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        console.log(`  ✗ removed: ${agentFile}`);
        removed++;
      }
    }

    saveBuildIndex(f, { generated: [...now].sort() });
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
      if (filename?.endsWith(".md")) {
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
    const outputDir = scope.outputDir;

    for (const agentFile of index.generated) {
      const filePath = path.join(outputDir, agentFile);
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        console.log(`  ✗ removed: ${agentFile}`);
        totalRemoved++;
      }
    }

    saveBuildIndex(f, { generated: [] });
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
