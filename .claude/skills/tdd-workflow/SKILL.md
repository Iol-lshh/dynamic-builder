---
name: tdd-workflow
description: Workflow: tdd-workflow
---

# Workflow: tdd-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/tdd-workflow.yaml`

> **검증 경고:**
> - tdd-test: agent `test-implementor` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/agents/`
> - tdd-implement: agent `code-level-implementor` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/agents/`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| tdd-analyze-A | usecase-analyst | spec 명세를 유스케이스 관점에서 분석하여 테스트 대상과 시나리오를 도출한다 |
| tdd-analyze-B | code-level-analyst | spec 명세를 코드 레벨 관점에서 분석하여 분기·경계값·예외 케이스를 도출한다 |
| tdd-tradeoff-advise | tradeoff-advisor | TDD 구현 방식의 트레이드오프를 조언한다 |
| tdd-constraint-advise | constraint-bypass-advisor | TDD 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) |
| tdd-scope-reduction-advise | scope-reduction-advisor | 최소 범위로 TDD 구현 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) |
| tdd-synthesis | scope-reduction-reconciler | 분석 및 조언 결과를 통합하여 TDD 구현 방향을 결정한다 |
| tdd-analysis-review | usecase-evaluator | 통합된 분석의 완전성과 테스트 시나리오 커버리지를 채점하고 개선 방향을 제시한다 |
| tdd-test-plan | test-planner | TDD 테스트 작성 계획을 수립한다 (테스트 순서, 픽스처, 경계값) |
| tdd-test-plan-advise | scope-reduction-advisor | 테스트 계획의 최소 범위 접근을 조언한다 |
| tdd-test-plan-validate | code-level-validator | 테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격) |
| tdd-test-plan-review | code-level-evaluator | 검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다 |
| tdd-test | test-implementor | 테스트 계획을 기반으로 실패하는 테스트를 작성한다 (TDD Red) |
| tdd-test-validate | code-level-validator | 작성된 테스트의 컴파일과 코딩 규칙 준수를 검증한다 (합격/불합격) |
| tdd-test-review | code-level-evaluator | 검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다 |
| tdd-implement | code-level-implementor | 실패하는 테스트를 통과시키는 최소한의 구현을 작성한다 (TDD Green) |
| tdd-implement-validate | code-level-validator | 구현된 코드의 컴파일, 테스트 통과, 코딩 규칙 준수를 검증한다 (합격/불합격) |
| tdd-implement-review | code-level-evaluator | 검증 통과된 코드의 설계 품질을 채점하고 개선 방향을 제시한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 6개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - (순차 흐름):
        1. **[STEP]** `tdd-analyze-A`
           - desc: spec 명세를 유스케이스 관점에서 분석하여 테스트 대상과 시나리오를 도출한다
           - agent: `usecase-analyst` → Agent 도구의 subagent_type
           - 산출물: `.local/$ARGUMENTS/tdd-analyze-A.md`

        2. **[STEP]** `tdd-tradeoff-advise`
           - desc: TDD 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/tdd-analyze-A.md`, `.local/$ARGUMENTS/tdd-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/tdd-tradeoff-advise.md`

       - `tdd-constraint-advise`: TDD 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `tdd-scope-reduction-advise`: 최소 범위로 TDD 구현 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)
       - (순차 흐름):
        1. **[STEP]** `tdd-analyze-B`
           - desc: spec 명세를 코드 레벨 관점에서 분석하여 분기·경계값·예외 케이스를 도출한다
           - agent: `code-level-analyst` → Agent 도구의 subagent_type
           - 산출물: `.local/$ARGUMENTS/tdd-analyze-B.md`

        2. **[STEP]** `tdd-tradeoff-advise`
           - desc: TDD 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/tdd-analyze-A.md`, `.local/$ARGUMENTS/tdd-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/tdd-tradeoff-advise.md`

       - `tdd-constraint-advise`: TDD 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `tdd-scope-reduction-advise`: 최소 범위로 TDD 구현 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)

    2. **[STEP]** `tdd-synthesis`
       - desc: 분석 및 조언 결과를 통합하여 TDD 구현 방향을 결정한다
       - agent: `scope-reduction-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-analyze-A.md`, `.local/$ARGUMENTS/tdd-analyze-B.md`, `.local/$ARGUMENTS/tdd-tradeoff-advise.md`, `.local/$ARGUMENTS/tdd-constraint-advise.md`, `.local/$ARGUMENTS/tdd-scope-reduction-advise.md`
       - 산출물: `.local/$ARGUMENTS/tdd-synthesis.md`

    3. **[STEP]** `tdd-analysis-review`
       - desc: 통합된 분석의 완전성과 테스트 시나리오 커버리지를 채점하고 개선 방향을 제시한다
       - agent: `usecase-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-synthesis.md`
       - 산출물: `.local/$ARGUMENTS/tdd-analysis-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

2. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

3. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[STEP]** `tdd-test-plan`
       - desc: TDD 테스트 작성 계획을 수립한다 (테스트 순서, 픽스처, 경계값)
       - agent: `test-planner` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-synthesis.md`, `.local/$ARGUMENTS/tdd-analysis-review.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test-plan.md`

    2. **[STEP]** `tdd-test-plan-advise`
       - desc: 테스트 계획의 최소 범위 접근을 조언한다
       - agent: `scope-reduction-advisor` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test-plan.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test-plan-advise.md`

    3. **[STEP]** `tdd-test-plan-validate`
       - desc: 테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격)
       - agent: `code-level-validator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test-plan.md`, `.local/$ARGUMENTS/tdd-test-plan-advise.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test-plan-validate.md`

    4. **[STEP]** `tdd-test-plan-review`
       - desc: 검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다
       - agent: `code-level-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test-plan.md`, `.local/$ARGUMENTS/tdd-test-plan-validate.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test-plan-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

4. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

5. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[STEP]** `tdd-test`
       - desc: 테스트 계획을 기반으로 실패하는 테스트를 작성한다 (TDD Red)
       - agent: `test-implementor` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test-plan.md`, `.local/$ARGUMENTS/tdd-test-plan-review.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test.md`

    2. **[STEP]** `tdd-test-validate`
       - desc: 작성된 테스트의 컴파일과 코딩 규칙 준수를 검증한다 (합격/불합격)
       - agent: `code-level-validator` → Agent 도구의 subagent_type
       - 산출물: `.local/$ARGUMENTS/tdd-test-validate.md`

    3. **[STEP]** `tdd-test-review`
       - desc: 검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다
       - agent: `code-level-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test.md`, `.local/$ARGUMENTS/tdd-test-validate.md`
       - 산출물: `.local/$ARGUMENTS/tdd-test-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

6. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

7. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[STEP]** `tdd-implement`
       - desc: 실패하는 테스트를 통과시키는 최소한의 구현을 작성한다 (TDD Green)
       - agent: `code-level-implementor` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-test.md`, `.local/$ARGUMENTS/tdd-test-review.md`
       - 산출물: `.local/$ARGUMENTS/tdd-implement.md`

    2. **[STEP]** `tdd-implement-validate`
       - desc: 구현된 코드의 컴파일, 테스트 통과, 코딩 규칙 준수를 검증한다 (합격/불합격)
       - agent: `code-level-validator` → Agent 도구의 subagent_type
       - 산출물: `.local/$ARGUMENTS/tdd-implement-validate.md`

    3. **[STEP]** `tdd-implement-review`
       - desc: 검증 통과된 코드의 설계 품질을 채점하고 개선 방향을 제시한다
       - agent: `code-level-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/tdd-implement.md`, `.local/$ARGUMENTS/tdd-implement-validate.md`
       - 산출물: `.local/$ARGUMENTS/tdd-implement-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

8. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
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
    # Phase 1: spec 분석
    - tdd-analyze-A:
        desc: "spec 명세를 유스케이스 관점에서 분석하여 테스트 대상과 시나리오를 도출한다"
        agent: usecase-analyst
    - tdd-analyze-B:
        desc: "spec 명세를 코드 레벨 관점에서 분석하여 분기·경계값·예외 케이스를 도출한다"
        agent: code-level-analyst

    - tdd-tradeoff-advise:
        desc: "TDD 구현 방식의 트레이드오프를 조언한다"
        input:
          - tdd-analyze-A
          - tdd-analyze-B
        agent: tradeoff-advisor
    - tdd-constraint-advise:
        desc: "TDD 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지)"
        input:
          - tdd-analyze-A
          - tdd-analyze-B
          - tdd-tradeoff-advise
        agent: constraint-bypass-advisor
    - tdd-scope-reduction-advise:
        desc: "최소 범위로 TDD 구현 목표를 달성하는 방안을 조언한다 (기존 조언과 중복 방지)"
        input:
          - tdd-analyze-A
          - tdd-analyze-B
          - tdd-tradeoff-advise
          - tdd-constraint-advise
        agent: scope-reduction-advisor

    - tdd-synthesis:
        desc: "분석 및 조언 결과를 통합하여 TDD 구현 방향을 결정한다"
        input:
          - tdd-analyze-A
          - tdd-analyze-B
          - tdd-tradeoff-advise
          - tdd-constraint-advise
          - tdd-scope-reduction-advise
        agent: scope-reduction-reconciler

    - tdd-analysis-review:
        desc: "통합된 분석의 완전성과 테스트 시나리오 커버리지를 채점하고 개선 방향을 제시한다"
        input:
          - tdd-synthesis
        agent: usecase-evaluator

    # Phase 2: 테스트 계획
    - tdd-test-plan:
        desc: "TDD 테스트 작성 계획을 수립한다 (테스트 순서, 픽스처, 경계값)"
        input:
          - tdd-synthesis
          - tdd-analysis-review
        agent: test-planner
    - tdd-test-plan-advise:
        desc: "테스트 계획의 최소 범위 접근을 조언한다"
        input:
          - tdd-test-plan
        agent: scope-reduction-advisor
    - tdd-test-plan-validate:
        desc: "테스트 계획의 완전성과 규칙 준수를 검증한다 (합격/불합격)"
        input:
          - tdd-test-plan
          - tdd-test-plan-advise
        agent: code-level-validator
    - tdd-test-plan-review:
        desc: "검증 통과된 테스트 계획의 품질을 채점하고 개선 방향을 제시한다"
        input:
          - tdd-test-plan
          - tdd-test-plan-validate
        agent: code-level-evaluator

    # Phase 3: 테스트 작성 (TDD Red)
    - tdd-test:
        desc: "테스트 계획을 기반으로 실패하는 테스트를 작성한다 (TDD Red)"
        input:
          - tdd-test-plan
          - tdd-test-plan-review
        agent: test-implementor
    - tdd-test-validate:
        desc: "작성된 테스트의 컴파일과 코딩 규칙 준수를 검증한다 (합격/불합격)"
        agent: code-level-validator
    - tdd-test-review:
        desc: "검증 통과된 테스트의 품질을 채점하고 개선 방향을 제시한다"
        input:
          - tdd-test
          - tdd-test-validate
        agent: code-level-evaluator

    # Phase 4: 코드 작성 (TDD Green)
    - tdd-implement:
        desc: "실패하는 테스트를 통과시키는 최소한의 구현을 작성한다 (TDD Green)"
        input:
          - tdd-test
          - tdd-test-review
        agent: code-level-implementor
    - tdd-implement-validate:
        desc: "구현된 코드의 컴파일, 테스트 통과, 코딩 규칙 준수를 검증한다 (합격/불합격)"
        agent: code-level-validator
    - tdd-implement-review:
        desc: "검증 통과된 코드의 설계 품질을 채점하고 개선 방향을 제시한다"
        input:
          - tdd-implement
          - tdd-implement-validate
        agent: code-level-evaluator

flow:
  # Phase 1: spec 분석
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - flow:
            - tdd-analyze-A
            - tdd-tradeoff-advise
            - tdd-constraint-advise
            - tdd-scope-reduction-advise
          - flow:
            - tdd-analyze-B
            - tdd-tradeoff-advise
            - tdd-constraint-advise
            - tdd-scope-reduction-advise
        - tdd-synthesis
        - tdd-analysis-review
  - hitl
  # Phase 2: 테스트 계획
  - retry:
      condition: score < 80
      max: 3
      flow:
        - tdd-test-plan
        - tdd-test-plan-advise
        - tdd-test-plan-validate
        - tdd-test-plan-review
  - hitl
  # Phase 3: 테스트 작성 (TDD Red)
  - retry:
      condition: score < 80
      max: 3
      flow:
        - tdd-test
        - tdd-test-validate
        - tdd-test-review
  - hitl
  # Phase 4: 코드 작성 (TDD Green)
  - retry:
      condition: score < 80
      max: 3
      flow:
        - tdd-implement
        - tdd-implement-validate
        - tdd-implement-review
  - hitl
```
