#!/usr/bin/env node
/**
 * Agent 빌드 스크립트
 *
 * template의 뼈대 파일에서 XML 태그를 src/ 내용으로 치환하여
 * 완성된 agent를 agents/build/에 생성합니다.
 *
 * 사용법:
 *   node build-agents.js
 *   node build-agents.js --watch
 *
 * 디렉토리 구조:
 *   skills/dynamic-agent-load/
 *     src/
 *       perspectives/*.md
 *       roles/*.md
 *       principles/*.md
 *     src/
 *       templates/
 *         domain-analyst.md
 *         usecase-analyst.md
 *     scripts/build-agents.js
 *   agents/
 *     domain-analyst.md        ← 빌드 결과물
 */

const fs = require("fs");
const os = require("os");
const path = require("path");

// ── 경로 설정 ──────────────────────────────────────────────
const SKILL_DIR = path.resolve(__dirname, "..");
const CLAUDE_DIR = path.join(os.homedir(), ".claude");

const SRC_DIR = path.join(SKILL_DIR, "src");
const TEMPLATE_DIR = path.join(SRC_DIR, "templates");

const PERSPECTIVES_DIR = path.join(SRC_DIR, "perspectives");
const ROLES_DIR = path.join(SRC_DIR, "roles");
const PRINCIPLES_DIR = path.join(SRC_DIR, "principles");

const BUILD_DIR = path.join(CLAUDE_DIR, "agents");
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

// ── 유틸 ──────────────────────────────────────────────────
function readFile(filePath) {
  if (!fs.existsSync(filePath)) {
    throw new Error(`파일을 찾을 수 없습니다: ${filePath}`);
  }
  return fs.readFileSync(filePath, "utf-8").trim();
}

function parseFrontmatter(content) {
  const match = content.match(/^---\n([\s\S]*?)\n---\n?([\s\S]*)$/);
  if (!match) return { meta: {}, body: content };

  const meta = {};
  for (const line of match[1].split("\n")) {
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
  return { meta, body: match[2].trim() };
}

// ── XML 태그에 내용 주입 ───────────────────────────────────
function injectTags(body) {
  body = body.replace(
    /<Perspective name="([^"]+)"><\/Perspective>/g,
    (_, name) => {
      const content = readFile(path.join(PERSPECTIVES_DIR, `${name}.md`));
      return `<Perspective name="${name}">\n${content}\n</Perspective>`;
    }
  );

  body = body.replace(
    /<Principle name="([^"]+)"><\/Principle>/g,
    (_, name) => {
      const content = readFile(path.join(PRINCIPLES_DIR, `${name}.md`));
      return `<Principle name="${name}">\n${content}\n</Principle>`;
    }
  );

  body = body.replace(/<Role name="([^"]+)"><\/Role>/g, (_, name) => {
    const content = readFile(path.join(ROLES_DIR, `${name}.md`));
    return `<Role name="${name}">\n${content}\n</Role>`;
  });

  return body;
}

// ── 핵심: 병합 ────────────────────────────────────────────
function buildAgent(templateFile) {
  const templateName = path.basename(templateFile, ".md");
  const templateContent = readFile(templateFile);
  const { meta, body } = parseFrontmatter(templateContent);

  const agentName = meta.name || templateName;
  const description = meta.description || "";
  const model = meta.model || "sonnet";
  const disallowedTools = meta.disallowedTools || [];

  const toolsLine =
    disallowedTools.length > 0
      ? `disallowedTools: [${disallowedTools.join(", ")}]\n`
      : "";

  const injectedBody = injectTags(body);

  const merged = `---
name: ${agentName}
description: ${description}
model: ${model}
${toolsLine}---
${injectedBody}`.trim();

  fs.mkdirSync(BUILD_DIR, { recursive: true });

  const outFile = path.join(BUILD_DIR, `${agentName}.md`);
  fs.writeFileSync(outFile, merged, "utf-8");

  console.log(`✓ ${agentName} → agents/${agentName}.md`);
}

// ── 전체 빌드 ─────────────────────────────────────────────
function buildAll() {
  if (!fs.existsSync(TEMPLATE_DIR)) {
    console.error(`템플릿 디렉토리를 찾을 수 없습니다: ${TEMPLATE_DIR}`);
    process.exit(1);
  }

  const files = fs
    .readdirSync(TEMPLATE_DIR)
    .filter((f) => f.endsWith(".md"));

  if (files.length === 0) {
    console.log("빌드할 템플릿 파일이 없습니다.");
    return;
  }

  console.log(`\n🔨 Agent 빌드 시작 (${files.length}개)\n`);

  const index = loadBuildIndex();
  const nowGenerated = new Set();

  let success = 0;
  let failed = 0;

  for (const file of files) {
    const name = path.basename(file, ".md");
    try {
      buildAgent(path.join(TEMPLATE_DIR, file));
      nowGenerated.add(`${name}.md`);
      success++;
    } catch (err) {
      console.error(`✗ ${file}: ${err.message}`);
      failed++;
    }
  }

  // 삭제된 템플릿에 대응하는 agent 파일 정리
  const previouslyGenerated = new Set(index.generated);
  let removed = 0;
  for (const agentFile of previouslyGenerated) {
    if (nowGenerated.has(agentFile)) continue;
    const filePath = path.join(BUILD_DIR, agentFile);
    if (fs.existsSync(filePath)) {
      fs.unlinkSync(filePath);
      console.log(`✗ removed: agents/${agentFile}`);
      removed++;
    }
  }

  saveBuildIndex({ generated: [...nowGenerated].sort() });

  console.log(`\n완료: ${success}개 성공, ${failed}개 실패, ${removed}개 삭제\n`);
}

// ── watch 모드 ────────────────────────────────────────────
function watchMode() {
  buildAll();
  console.log("👀 파일 변경 감지 중... (Ctrl+C로 종료)\n");

  const watchDirs = [TEMPLATE_DIR, SRC_DIR];
  for (const dir of watchDirs) {
    if (!fs.existsSync(dir)) continue;
    fs.watch(dir, { recursive: true }, (_, filename) => {
      if (filename?.endsWith(".md")) {
        console.log(`\n변경 감지: ${filename}`);
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
  for (const agentFile of index.generated) {
    const filePath = path.join(BUILD_DIR, agentFile);
    if (fs.existsSync(filePath)) {
      fs.unlinkSync(filePath);
      console.log(`✗ removed: agents/${agentFile}`);
      removed++;
    }
  }

  saveBuildIndex({ generated: [] });
  console.log(`\n완료: ${removed}개 삭제\n`);
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