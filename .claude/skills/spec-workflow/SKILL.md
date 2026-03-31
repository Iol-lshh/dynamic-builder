---
name: spec-workflow
description: Workflow: spec-workflow
---

# Workflow: spec-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/spec-workflow.yaml`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| spec-analyze-A | usecase-analyst | 자연어 요구사항을 유스케이스 관점에서 구조화된 요구사항 문서로 변환한다 |
| spec-analyze-B | domain-analyst | 자연어 요구사항을 도메인 모델 관점에서 구조화된 요구사항 문서로 변환한다 |
| spec-tradeoff-advise | tradeoff-advisor | 요구사항 분석 결과를 바탕으로 구현 방식의 트레이드오프를 조언한다 |
| spec-constraint-advise | constraint-bypass-advisor | 요구사항 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) |
| spec-scope-reduction-advise | scope-reduction-advisor | 최소 범위로 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) |
| spec-synthesis | scope-reduction-reconciler | 분석 및 조언 결과를 통합하여 최종 요구사항 문서를 결정한다 |
| spec-review | usecase-evaluator | 요구사항 문서의 유스케이스 완전성과 행위 흐름을 채점하고 개선 방향을 제시한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 6개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - (순차 흐름):
        1. **[STEP]** `spec-analyze-A`
           - desc: 자연어 요구사항을 유스케이스 관점에서 구조화된 요구사항 문서로 변환한다
           - agent: `usecase-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/usecase-guide.md`, `references/output-format.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/spec-analyze-A.md`

        2. **[STEP]** `spec-tradeoff-advise`
           - desc: 요구사항 분석 결과를 바탕으로 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/spec-analyze-A.md`, `.local/$ARGUMENTS/spec-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/spec-tradeoff-advise.md`

       - `spec-constraint-advise`: 요구사항 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `spec-scope-reduction-advise`: 최소 범위로 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)
       - (순차 흐름):
        1. **[STEP]** `spec-analyze-B`
           - desc: 자연어 요구사항을 도메인 모델 관점에서 구조화된 요구사항 문서로 변환한다
           - agent: `domain-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/usecase-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/spec-analyze-B.md`

        2. **[STEP]** `spec-tradeoff-advise`
           - desc: 요구사항 분석 결과를 바탕으로 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/spec-analyze-A.md`, `.local/$ARGUMENTS/spec-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/spec-tradeoff-advise.md`

       - `spec-constraint-advise`: 요구사항 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `spec-scope-reduction-advise`: 최소 범위로 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)

    2. **[STEP]** `spec-synthesis`
       - desc: 분석 및 조언 결과를 통합하여 최종 요구사항 문서를 결정한다
       - agent: `scope-reduction-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/spec-analyze-A.md`, `.local/$ARGUMENTS/spec-analyze-B.md`, `.local/$ARGUMENTS/spec-tradeoff-advise.md`, `.local/$ARGUMENTS/spec-constraint-advise.md`, `.local/$ARGUMENTS/spec-scope-reduction-advise.md`
       - 산출물: `.local/$ARGUMENTS/spec-synthesis.md`

    3. **[STEP]** `spec-review`
       - desc: 요구사항 문서의 유스케이스 완전성과 행위 흐름을 채점하고 개선 방향을 제시한다
       - agent: `usecase-evaluator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/usecase-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/spec-synthesis.md`
       - 산출물: `.local/$ARGUMENTS/spec-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

2. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행


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
define:
  steps:
    - spec-analyze-A:
        desc: "자연어 요구사항을 유스케이스 관점에서 구조화된 요구사항 문서로 변환한다"
        details:
          - usecase-guide.md
          - output-format.md
        agent: usecase-analyst
    - spec-analyze-B:
        desc: "자연어 요구사항을 도메인 모델 관점에서 구조화된 요구사항 문서로 변환한다"
        details:
          - usecase-guide.md
        agent: domain-analyst

    - spec-tradeoff-advise:
        desc: "요구사항 분석 결과를 바탕으로 구현 방식의 트레이드오프를 조언한다"
        input:
          - spec-analyze-A
          - spec-analyze-B
        agent: tradeoff-advisor
    - spec-constraint-advise:
        desc: "요구사항 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지)"
        input:
          - spec-analyze-A
          - spec-analyze-B
          - spec-tradeoff-advise
        agent: constraint-bypass-advisor
    - spec-scope-reduction-advise:
        desc: "최소 범위로 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지)"
        input:
          - spec-analyze-A
          - spec-analyze-B
          - spec-tradeoff-advise
          - spec-constraint-advise
        agent: scope-reduction-advisor

    - spec-synthesis:
        desc: "분석 및 조언 결과를 통합하여 최종 요구사항 문서를 결정한다"
        input:
          - spec-analyze-A
          - spec-analyze-B
          - spec-tradeoff-advise
          - spec-constraint-advise
          - spec-scope-reduction-advise
        agent: scope-reduction-reconciler

    - spec-review:
        desc: "요구사항 문서의 유스케이스 완전성과 행위 흐름을 채점하고 개선 방향을 제시한다"
        details:
          - usecase-guide.md
        input:
          - spec-synthesis
        agent: usecase-evaluator

flow:
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - flow:
            - spec-analyze-A
            - spec-tradeoff-advise
            - spec-constraint-advise
            - spec-scope-reduction-advise
          - flow:
            - spec-analyze-B
            - spec-tradeoff-advise
            - spec-constraint-advise
            - spec-scope-reduction-advise
        - spec-synthesis
        - spec-review
  - hitl
```
