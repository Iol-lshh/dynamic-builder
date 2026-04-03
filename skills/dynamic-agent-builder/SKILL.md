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

## 빌드 동작

빌드 시 두 가지 처리가 수행된다:

1. **Frontmatter 병합**: role의 default → template의 override 순서로 agent frontmatter를 결정
2. **XML 태그 치환**: 본문의 XML 태그를 `src/` 내용으로 치환

### Frontmatter 오버라이드

`src/roles/`의 frontmatter가 default, `templates/`의 frontmatter가 override:

```
role default  →  template override  →  agent 결과
```

template에 `model`, `effort`, `maxTokens`, `disallowedTools`를 명시하면 role default를 덮어쓴다. 명시하지 않으면 role default가 사용된다.

### 템플릿 파일 형식

`templates/{perspective}-{role}.md`:

```markdown
---
name: usecase-analyst
description: 유스케이스 관점에서 요구사항을 분석하는 분석가
---

<Agent>
  <Perspective name="usecase-design"></Perspective>
  <Role name="analyst"></Role>
  <Principle name="common"></Principle>
</Agent>
```

### XML 태그 치환

- `<Perspective name="X">` → `src/perspectives/X.md`
- `<Role name="X">` → `src/roles/X.md`
- `<Principle name="X">` → `src/principles/X.md`

## 파일 구조

```
skills/dynamic-agent-builder/
  SKILL.md                          ← 이 파일
  src/                              ← 조합 요소
    perspectives/*.md
    roles/*.md                      ← frontmatter로 default 옵션 선언
    principles/*.md
  templates/                         ← 조합할 뼈대 (직접 편집)
    domain-analyst.md
    usecase-analyst.md
    ...
  scripts/
    build-agents.js                 ← 빌드 스크립트

~/.claude/agents/
    domain-analyst.md               ← 빌드 결과물 (자동 생성, 편집 금지)
    usecase-analyst.md
    ...
```

## 규칙

- `agents/build/`의 파일을 직접 수정하지 않는다. `src/`나 `templates/`을 수정하고 다시 빌드한다.
- 새 agent가 필요하면 `templates/`에 뼈대 파일을 추가하고 빌드한다.
- `{perspective}-{role}` 네이밍을 따른다.