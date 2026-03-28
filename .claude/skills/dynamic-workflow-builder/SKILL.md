---
name: dynamic-workflow-builder
description: 워크플로우 정의 파일을 읽어 step들을 제어 흐름(flow, parallel, if, retry)에 따라 실행한다.
argument-hint: <workflow-yaml-path>
---

# Dynamic Workflow Builder

`$ARGUMENTS`의 워크플로우 정의 파일을 실행한다.

> **문법 참조**: `references/GRAMMER.md`

## 절차

1. 워크플로우 YAML 파일을 파싱한다
2. define 섹션에서 step들을 로드한다 (skill + agent 확인)
3. flow 섹션을 제어 흐름에 따라 실행한다

```bash
node ~/.claude/skills/dynamic-workflow-builder/scripts/build-workflow.js $ARGUMENTS
```