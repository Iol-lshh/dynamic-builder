---
name: coverage-workflow
description: Workflow: coverage-workflow
---

# Workflow: coverage-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/coverage-workflow.yaml`

> **검증 경고:**
> - coverage-test: agent `test-implementor` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/agents/`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| coverage-analyze-A | usecase-analyst | 컨디션 커버리지 누락 분기를 유스케이스 관점에서 식별한다 |
| coverage-analyze-B | code-level-analyst | 컨디션 커버리지 누락 분기를 코드 레벨 관점에서 식별한다 |
| coverage-tradeoff-advise | tradeoff-advisor | 커버리지 분석 결과를 바탕으로 테스트 전략의 트레이드오프를 조언한다 |
| coverage-constraint-advise | constraint-bypass-advisor | 커버리지 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) |
| coverage-scope-reduction-advise | scope-reduction-advisor | 최소 범위로 커버리지 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) |
| coverage-synthesis | scope-reduction-reconciler | 분석 및 조언 결과를 통합하여 커버리지 테스트 계획 방향을 결정한다 |
| coverage-plan | test-analyst | 커버리지 테스트 작성 계획을 수립한다 |
| coverage-plan-validate | usecase-validator | 커버리지 테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격) |
| coverage-plan-review | usecase-evaluator | 검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다 |
| coverage-test | test-implementor | 컨디션 커버리지 테스트를 작성한다 |
| coverage-validate | code-level-validator | 테스트 컴파일, 실행 통과, JaCoCo 커버리지 기준 충족을 검증한다 (합격/불합격) |
| coverage-review | code-level-evaluator | 검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 6개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - (순차 흐름):
        1. **[STEP]** `coverage-analyze-A`
           - desc: 컨디션 커버리지 누락 분기를 유스케이스 관점에서 식별한다
           - agent: `usecase-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/condition-coverage-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/coverage-analyze-A.md`

        2. **[STEP]** `coverage-tradeoff-advise`
           - desc: 커버리지 분석 결과를 바탕으로 테스트 전략의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/coverage-analyze-A.md`, `.local/$ARGUMENTS/coverage-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/coverage-tradeoff-advise.md`

       - `coverage-constraint-advise`: 커버리지 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `coverage-scope-reduction-advise`: 최소 범위로 커버리지 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)
       - (순차 흐름):
        1. **[STEP]** `coverage-analyze-B`
           - desc: 컨디션 커버리지 누락 분기를 코드 레벨 관점에서 식별한다
           - agent: `code-level-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/condition-coverage-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/coverage-analyze-B.md`

        2. **[STEP]** `coverage-tradeoff-advise`
           - desc: 커버리지 분석 결과를 바탕으로 테스트 전략의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/coverage-analyze-A.md`, `.local/$ARGUMENTS/coverage-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/coverage-tradeoff-advise.md`

       - `coverage-constraint-advise`: 커버리지 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `coverage-scope-reduction-advise`: 최소 범위로 커버리지 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)

    2. **[STEP]** `coverage-synthesis`
       - desc: 분석 및 조언 결과를 통합하여 커버리지 테스트 계획 방향을 결정한다
       - agent: `scope-reduction-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/coverage-analyze-A.md`, `.local/$ARGUMENTS/coverage-analyze-B.md`, `.local/$ARGUMENTS/coverage-tradeoff-advise.md`, `.local/$ARGUMENTS/coverage-constraint-advise.md`, `.local/$ARGUMENTS/coverage-scope-reduction-advise.md`
       - 산출물: `.local/$ARGUMENTS/coverage-synthesis.md`

    3. **[STEP]** `coverage-plan`
       - desc: 커버리지 테스트 작성 계획을 수립한다
       - agent: `test-analyst` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/coverage-synthesis.md`
       - 산출물: `.local/$ARGUMENTS/coverage-plan.md`

    4. **[STEP]** `coverage-plan-validate`
       - desc: 커버리지 테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격)
       - agent: `usecase-validator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/coverage-plan.md`
       - 산출물: `.local/$ARGUMENTS/coverage-plan-validate.md`

    5. **[STEP]** `coverage-plan-review`
       - desc: 검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다
       - agent: `usecase-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/coverage-plan.md`, `.local/$ARGUMENTS/coverage-plan-validate.md`
       - 산출물: `.local/$ARGUMENTS/coverage-plan-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

2. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

3. **[RETRY]** 조건: `score < 80`, 최대: 2회
   반복 내부 흐름:
    1. **[STEP]** `coverage-test`
       - desc: 컨디션 커버리지 테스트를 작성한다
       - agent: `test-implementor` → Agent 도구의 subagent_type
       - details (필수 준수): `references/condition-coverage-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/coverage-plan.md`
       - 산출물: `.local/$ARGUMENTS/coverage-test.md`

    2. **[STEP]** `coverage-validate`
       - desc: 테스트 컴파일, 실행 통과, JaCoCo 커버리지 기준 충족을 검증한다 (합격/불합격)
       - agent: `code-level-validator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/condition-coverage-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - 산출물: `.local/$ARGUMENTS/coverage-validate.md`

    3. **[STEP]** `coverage-review`
       - desc: 검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다
       - agent: `code-level-evaluator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/condition-coverage-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/coverage-test.md`, `.local/$ARGUMENTS/coverage-validate.md`
       - 산출물: `.local/$ARGUMENTS/coverage-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 2회.

4. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
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
    - coverage-analyze-A:
        desc: "컨디션 커버리지 누락 분기를 유스케이스 관점에서 식별한다"
        details:
          - condition-coverage-guide.md
        agent: usecase-analyst
    - coverage-analyze-B:
        desc: "컨디션 커버리지 누락 분기를 코드 레벨 관점에서 식별한다"
        details:
          - condition-coverage-guide.md
        agent: code-level-analyst

    - coverage-tradeoff-advise:
        desc: "커버리지 분석 결과를 바탕으로 테스트 전략의 트레이드오프를 조언한다"
        input:
          - coverage-analyze-A
          - coverage-analyze-B
        agent: tradeoff-advisor
    - coverage-constraint-advise:
        desc: "커버리지 달성의 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지)"
        input:
          - coverage-analyze-A
          - coverage-analyze-B
          - coverage-tradeoff-advise
        agent: constraint-bypass-advisor
    - coverage-scope-reduction-advise:
        desc: "최소 범위로 커버리지 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지)"
        input:
          - coverage-analyze-A
          - coverage-analyze-B
          - coverage-tradeoff-advise
          - coverage-constraint-advise
        agent: scope-reduction-advisor

    - coverage-synthesis:
        desc: "분석 및 조언 결과를 통합하여 커버리지 테스트 계획 방향을 결정한다"
        input:
          - coverage-analyze-A
          - coverage-analyze-B
          - coverage-tradeoff-advise
          - coverage-constraint-advise
          - coverage-scope-reduction-advise
        agent: scope-reduction-reconciler

    - coverage-plan:
        desc: "커버리지 테스트 작성 계획을 수립한다"
        input:
          - coverage-synthesis
        agent: test-analyst

    - coverage-plan-validate:
        desc: "커버리지 테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격)"
        input:
          - coverage-plan
        agent: usecase-validator
    - coverage-plan-review:
        desc: "검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다"
        input:
          - coverage-plan
          - coverage-plan-validate
        agent: usecase-evaluator

    - coverage-test:
        desc: "컨디션 커버리지 테스트를 작성한다"
        details:
          - condition-coverage-guide.md
        input:
          - coverage-plan
        agent: test-implementor

    - coverage-validate:
        desc: "테스트 컴파일, 실행 통과, JaCoCo 커버리지 기준 충족을 검증한다 (합격/불합격)"
        details:
          - condition-coverage-guide.md
        agent: code-level-validator
    - coverage-review:
        desc: "검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다"
        details:
          - condition-coverage-guide.md
        input:
          - coverage-test
          - coverage-validate
        agent: code-level-evaluator

flow:
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - flow:
            - coverage-analyze-A
            - coverage-tradeoff-advise
            - coverage-constraint-advise
            - coverage-scope-reduction-advise
          - flow:
            - coverage-analyze-B
            - coverage-tradeoff-advise
            - coverage-constraint-advise
            - coverage-scope-reduction-advise
        - coverage-synthesis
        - coverage-plan
        - coverage-plan-validate
        - coverage-plan-review
  - hitl
  - retry:
      condition: score < 80
      max: 2
      flow:
        - coverage-test
        - coverage-validate
        - coverage-review
  - hitl
```
