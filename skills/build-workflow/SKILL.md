---
name: build-workflow
description: 워크플로우 정의 파일을 읽어 step들을 제어 흐름(flow, parallel, if, retry)에 따라 실행한다.
argument-hint: [--watch|--clean|<workflow-yaml-path>]
---

# Dynamic Workflow Builder — 워크플로우 동적 빌드

`templates/`의 워크플로우 YAML 정의를 읽어 `~/.claude/skills/{name}/`에 실행 가능한 skill을 생성한다.

> **문법 참조**: `references/GRAMMAR.md`

## 사용법

```bash
node ~/.claude/skills/build-workflow/scripts/build-workflow.js
node ~/.claude/skills/build-workflow/scripts/build-workflow.js --watch
node ~/.claude/skills/build-workflow/scripts/build-workflow.js --clean
```

## 워크플로우 파일 형식

`templates/{name}-workflow.yaml`:

```yaml
output-dir: .local/{작업 제목}

define:
  steps:
    - step-name:
        desc: "task description"
        agent: agent-name
        details:
          - detail-file.md
        refs:
          - reference-file.md
        input:
          - previous-step
        output: output-file.md

flow:
  - step-a
  - parallel:
    - step-b
    - step-c
  - if:
      condition: score < 80
      flow: [step-d]
  - retry:
      condition: score < 80
      max: 2
      flow: [step-e]
```

빌드 시 YAML 정의가 실행 가능한 skill 구조로 변환된다:
- `define.steps` → 각 step의 agent + desc + refs 조합
- `flow` → 순차/병렬/조건/재시도 제어 흐름
- `details` → `src/details/` 기준, 빌드 시 `references/`로 복사

## 파일 구조

```
skills/build-workflow/
  SKILL.md                          ← 이 파일
  references/
    GRAMMAR.md                      ← 워크플로우 정의 문법
  src/                              ← 조합 요소
    details/*.md                    ← step별 지침
    templates/*.yaml                ← 워크플로우 정의
  scripts/
    build-workflow.js               ← 빌드 스크립트

~/.claude/skills/
    {name}/SKILL.md                 ← 빌드 결과물 (자동 생성, 편집 금지)
    {name}/references/*.md
```

## 규칙

- `~/.claude/skills/{name}/`의 빌드 결과물을 직접 수정하지 않는다. `src/`나 `templates/`을 수정하고 다시 빌드한다.
- 새 워크플로우가 필요하면 `templates/`에 YAML 파일을 추가하고 빌드한다.
- `{name}-workflow` 네이밍을 따른다.
