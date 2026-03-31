---
name: create-workflow-blueprint
description: Workflow: create-workflow-blueprint
---

# Workflow: create-workflow-blueprint

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/create-workflow-blueprint.yaml`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| analyze | workflow-design-analyst | 사용자 요구사항을 분석하여 필요한 워크플로우 구조와 에이전트 구성을 파악한다 |
| wf-plan | workflow-design-planner | 워크플로우 YAML 구조를 설계한다 (스텝 정의, 제어 흐름, 데이터 흐름) |
| wf-review | workflow-design-evaluator | 워크플로우 설계의 완전성과 문법 준수를 채점하고 개선 방향을 제시한다 |
| wf-advise | tradeoff-advisor | 워크플로우 구조의 트레이드오프를 분석하고 대안을 조언한다 |
| ag-plan | agent-composition-planner | 필요한 에이전트 템플릿을 설계한다 (perspective/role/principle 조합, 기존 재사용 우선... |
| ag-review | agent-composition-evaluator | 에이전트 구성의 적절성과 기존 컴포넌트 재사용률을 채점하고 개선 방향을 제시한다 |
| ag-advise | scope-reduction-advisor | 에이전트 구성의 최소화 방안을 조언한다 |
| reconcile | workflow-design-reconciler | 워크플로우 설계와 에이전트 구성을 통합하여 최종 설계를 도출한다 |
| design-review | workflow-design-evaluator | 통합된 설계의 완전성, 일관성, 실현 가능성을 채점하고 개선 방향을 제시한다 |
| build | workflow-design-builder | 최종 설계를 바탕으로 워크플로우 YAML과 에이전트 템플릿 파일을 생성한다 |
| build-validate | workflow-design-validator | 생성된 파일의 YAML 문법, 참조 무결성, 빌드 가능성을 검증한다 (합격/불합격) |
| build-review | workflow-design-evaluator | 검증 통과된 산출물의 설계 품질을 채점하고 개선 방향을 제시한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[STEP]** `analyze`
   - desc: 사용자 요구사항을 분석하여 필요한 워크플로우 구조와 에이전트 구성을 파악한다
   - agent: `workflow-design-analyst` → Agent 도구의 subagent_type
   - details (필수 준수): `references/workflow-complexity-guide.md`, `references/workflow-template-guide.md`, `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
   - 산출물: `.local/$ARGUMENTS/analyze.md`

2. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 4개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - (순차 흐름):
        1. **[STEP]** `wf-plan`
           - desc: 워크플로우 YAML 구조를 설계한다 (스텝 정의, 제어 흐름, 데이터 흐름)
           - agent: `workflow-design-planner` → Agent 도구의 subagent_type
           - details (필수 준수): `references/workflow-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - input: `.local/$ARGUMENTS/analyze.md`
           - 산출물: `.local/$ARGUMENTS/wf-plan.md`

        2. **[STEP]** `wf-review`
           - desc: 워크플로우 설계의 완전성과 문법 준수를 채점하고 개선 방향을 제시한다
           - agent: `workflow-design-evaluator` → Agent 도구의 subagent_type
           - details (필수 준수): `references/workflow-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - input: `.local/$ARGUMENTS/wf-plan.md`
           - 산출물: `.local/$ARGUMENTS/wf-review.md`

       - `wf-advise`: 워크플로우 구조의 트레이드오프를 분석하고 대안을 조언한다 (agent: `tradeoff-advisor`)
       - (순차 흐름):
        1. **[STEP]** `ag-plan`
           - desc: 필요한 에이전트 템플릿을 설계한다 (perspective/role/principle 조합, 기존 재사용 우선)
           - agent: `agent-composition-planner` → Agent 도구의 subagent_type
           - details (필수 준수): `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - input: `.local/$ARGUMENTS/analyze.md`
           - 산출물: `.local/$ARGUMENTS/ag-plan.md`

        2. **[STEP]** `ag-review`
           - desc: 에이전트 구성의 적절성과 기존 컴포넌트 재사용률을 채점하고 개선 방향을 제시한다
           - agent: `agent-composition-evaluator` → Agent 도구의 subagent_type
           - details (필수 준수): `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - input: `.local/$ARGUMENTS/ag-plan.md`
           - 산출물: `.local/$ARGUMENTS/ag-review.md`

       - `ag-advise`: 에이전트 구성의 최소화 방안을 조언한다 (agent: `scope-reduction-advisor`)

    2. **[STEP]** `reconcile`
       - desc: 워크플로우 설계와 에이전트 구성을 통합하여 최종 설계를 도출한다
       - agent: `workflow-design-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/wf-plan.md`, `.local/$ARGUMENTS/wf-advise.md`, `.local/$ARGUMENTS/ag-plan.md`, `.local/$ARGUMENTS/ag-advise.md`
       - 산출물: `.local/$ARGUMENTS/reconcile.md`

    3. **[STEP]** `design-review`
       - desc: 통합된 설계의 완전성, 일관성, 실현 가능성을 채점하고 개선 방향을 제시한다
       - agent: `workflow-design-evaluator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/workflow-template-guide.md`, `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/reconcile.md`
       - 산출물: `.local/$ARGUMENTS/design-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

3. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

4. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[STEP]** `build`
       - desc: 최종 설계를 바탕으로 워크플로우 YAML과 에이전트 템플릿 파일을 생성한다
       - agent: `workflow-design-builder` → Agent 도구의 subagent_type
       - details (필수 준수): `references/workflow-template-guide.md`, `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/reconcile.md`, `.local/$ARGUMENTS/design-review.md`
       - 산출물: `.local/$ARGUMENTS/build.md`

    2. **[STEP]** `build-validate`
       - desc: 생성된 파일의 YAML 문법, 참조 무결성, 빌드 가능성을 검증한다 (합격/불합격)
       - agent: `workflow-design-validator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/workflow-template-guide.md`, `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/build.md`
       - 산출물: `.local/$ARGUMENTS/build-validate.md`

    3. **[STEP]** `build-review`
       - desc: 검증 통과된 산출물의 설계 품질을 채점하고 개선 방향을 제시한다
       - agent: `workflow-design-evaluator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/workflow-template-guide.md`, `references/agent-template-guide.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/build.md`, `.local/$ARGUMENTS/build-validate.md`
       - 산출물: `.local/$ARGUMENTS/build-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

5. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
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
    - analyze:
        desc: "사용자 요구사항을 분석하여 필요한 워크플로우 구조와 에이전트 구성을 파악한다"
        details:
          - workflow-complexity-guide.md
          - workflow-template-guide.md
          - agent-template-guide.md
        agent: workflow-design-analyst

    - wf-plan:
        desc: "워크플로우 YAML 구조를 설계한다 (스텝 정의, 제어 흐름, 데이터 흐름)"
        details:
          - workflow-template-guide.md
        input:
          - analyze
        agent: workflow-design-planner
    - wf-review:
        desc: "워크플로우 설계의 완전성과 문법 준수를 채점하고 개선 방향을 제시한다"
        details:
          - workflow-template-guide.md
        input:
          - wf-plan
        agent: workflow-design-evaluator
    - wf-advise:
        desc: "워크플로우 구조의 트레이드오프를 분석하고 대안을 조언한다"
        input:
          - wf-plan
          - wf-review
        agent: tradeoff-advisor

    - ag-plan:
        desc: "필요한 에이전트 템플릿을 설계한다 (perspective/role/principle 조합, 기존 재사용 우선)"
        details:
          - agent-template-guide.md
        input:
          - analyze
        agent: agent-composition-planner
    - ag-review:
        desc: "에이전트 구성의 적절성과 기존 컴포넌트 재사용률을 채점하고 개선 방향을 제시한다"
        details:
          - agent-template-guide.md
        input:
          - ag-plan
        agent: agent-composition-evaluator
    - ag-advise:
        desc: "에이전트 구성의 최소화 방안을 조언한다"
        input:
          - ag-plan
          - ag-review
        agent: scope-reduction-advisor

    - reconcile:
        desc: "워크플로우 설계와 에이전트 구성을 통합하여 최종 설계를 도출한다"
        input:
          - wf-plan
          - wf-advise
          - ag-plan
          - ag-advise
        agent: workflow-design-reconciler
    - design-review:
        desc: "통합된 설계의 완전성, 일관성, 실현 가능성을 채점하고 개선 방향을 제시한다"
        details:
          - workflow-template-guide.md
          - agent-template-guide.md
        input:
          - reconcile
        agent: workflow-design-evaluator

    - build:
        desc: "최종 설계를 바탕으로 워크플로우 YAML과 에이전트 템플릿 파일을 생성한다"
        details:
          - workflow-template-guide.md
          - agent-template-guide.md
        input:
          - reconcile
          - design-review
        agent: workflow-design-builder
    - build-validate:
        desc: "생성된 파일의 YAML 문법, 참조 무결성, 빌드 가능성을 검증한다 (합격/불합격)"
        details:
          - workflow-template-guide.md
          - agent-template-guide.md
        input:
          - build
        agent: workflow-design-validator
    - build-review:
        desc: "검증 통과된 산출물의 설계 품질을 채점하고 개선 방향을 제시한다"
        details:
          - workflow-template-guide.md
          - agent-template-guide.md
        input:
          - build
          - build-validate
        agent: workflow-design-evaluator

flow:
  - analyze
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - flow:
            - wf-plan
            - wf-review
            - wf-advise
          - flow:
            - ag-plan
            - ag-review
            - ag-advise
        - reconcile
        - design-review
  - hitl
  - retry:
      condition: score < 80
      max: 3
      flow:
        - build
        - build-validate
        - build-review
  - hitl
```
