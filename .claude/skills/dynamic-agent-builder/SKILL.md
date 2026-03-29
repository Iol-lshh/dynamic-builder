---
name: dynamic-agent-builder
description: perspective + role 템플릿을 빌드하여 완성된 agent를 생성한다. templates → agents/build
argument-hint: [--watch|--clean]
---

# Dynamic Agent Builder — 에이전트 동적 빌드

`templates/`의 뼈대 파일에서 XML 태그를 `src/` 내용으로 치환하여 `agents/build/`에 완성된 agent를 생성한다.

## 사용법

```bash
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js --watch
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js --clean
```

## 템플릿 파일 형식

`templates/{perspective}-{role}.md`:

```markdown
---
name: usecase-analyst
description: 유스케이스 관점에서 요구사항을 분석하는 분석가
model: opus
disallowedTools: [Edit]
---

<Agent>
  <Perspective name="usecase-design"></Perspective>
  <Role name="analyst"></Role>
  <Principle name="common"></Principle>
</Agent>
```

빌드 시 XML 태그가 `src/` 내용으로 치환된다:
- `<Perspective name="X">` → `src/perspectives/X.md`
- `<Role name="X">` → `src/roles/X.md`
- `<Principle name="X">` → `src/principles/X.md`

## 파일 구조

```
skills/dynamic-agent-builder/
  SKILL.md                          ← 이 파일
  src/                              ← 조합 요소
    perspectives/*.md
    roles/*.md
    principles/*.md
  templates/                         ← 조합할 뼈대 (직접 편집)
    domain-analyst.md
    usecase-analyst.md
    ...
  scripts/
    build-agents.js                 ← 빌드 스크립트

agents/
  build/                            ← 빌드 결과물 (자동 생성, 편집 금지)
    domain-analyst.md
    usecase-analyst.md
    ...
```

## 규칙

- `agents/build/`의 파일을 직접 수정하지 않는다. `src/`나 `templates/`을 수정하고 다시 빌드한다.
- 새 agent가 필요하면 `templates/`에 뼈대 파일을 추가하고 빌드한다.
- `{perspective}-{role}` 네이밍을 따른다.