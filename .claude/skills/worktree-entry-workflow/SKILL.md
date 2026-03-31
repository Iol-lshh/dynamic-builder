---
name: worktree-entry-workflow
description: Workflow: worktree-entry-workflow
---

# Workflow: worktree-entry-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/worktree-entry-workflow.yaml`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| task-start | task-lifecycle-starter | $ARGUMENTS 작업명으로 worktree를 생성하고 세션을 전환한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[STEP]** `task-start`
   - desc: $ARGUMENTS 작업명으로 worktree를 생성하고 세션을 전환한다
   - agent: `task-lifecycle-starter` → Agent 도구의 subagent_type
   - details (필수 준수): `references/worktree-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
   - 산출물: `.local/$ARGUMENTS/task-start.md`


## 실행 규칙

- 각 **[STEP]**은 Agent 도구로 서브에이전트를 실행한다.
  - agent 파일: `~/.claude/agents/{agent}.md`를 읽어 프롬프트에 포함
  - desc를 task 설명으로 서브에이전트에 전달
  - refs 파일들(`~/.claude/references/`)을 컨텍스트로 서브에이전트에 제공
  - details 파일들(`references/`)은 **반드시 준수해야 할 지침**이다. 에이전트 프롬프트에 포함하고 "이 details 파일의 지침을 반드시 따르라"고 명시한다
  - input step들의 산출물을 입력으로 전달
  - `$STEP_NAME`으로 step 이름을 전달하여 산출물 파일명을 결정
- **[SHELL]**은 Bash 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[TOOL]**은 명시된 Claude 도구를 직접 호출한다. 서브에이전트 없이 오케스트레이터가 실행한다.
- **[PARALLEL]**은 하나의 메시지에 여러 Agent 호출을 포함하여 동시 실행한다.
- **[RETRY]**는 내부 흐름 실행 후 조건을 평가한다. score는 review step 산출물에서 추출한다.
- **[HITL]**에서 사용자가 피드백을 주면, 직전 단계를 피드백과 함께 재실행한다.
- 산출물은 `.local/$ARGUMENTS/` 디렉토리에 파일로 저장한다. 메인 컨텍스트에 산출물 내용을 넣지 않는다.
- 워크플로우 시작 시 해당 디렉토리를 미리 생성한다 (mkdir -p).
- 서브에이전트 완료 후 산출물 파일 경로만 사용자에게 보고한다.

## 원본 정의

```yaml
# $ARGUMENTS = 작업명 (worktree 브랜치명으로 사용)
define:
  steps:
    - task-start:
        desc: "$ARGUMENTS 작업명으로 worktree를 생성하고 세션을 전환한다"
        agent: task-lifecycle-starter
        details:
          - worktree-entry.md

flow:
  - task-start
```
