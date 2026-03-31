---
name: page-workflow
description: Workflow: page-workflow
---

# Workflow: page-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/page-workflow.yaml`

> **검증 경고:**
> - page-analyze-A: details `thymeleaf-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-analyze-A: details `hybrids-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-analyze-B: details `thymeleaf-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-analyze-B: details `hybrids-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-uiux-review: details `thymeleaf-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-uiux-review: details `hybrids-guide-index.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: agent `uiux-planner` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/agents/`
> - page-plan: details `thymeleaf-page-template.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `thymeleaf-ui-components.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `thymeleaf-data-passing.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `js-module-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `hybrids-component-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `hybrids-store-state.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `hybrids-ui-patterns.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan: details `hybrids-page-entry.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `thymeleaf-page-template.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `thymeleaf-ui-components.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `thymeleaf-data-passing.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `js-module-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `hybrids-component-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `hybrids-store-state.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `hybrids-ui-patterns.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-plan-validate: details `hybrids-page-entry.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: agent `uiux-implementor` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/agents/`
> - page-implements: details `thymeleaf-page-template.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `thymeleaf-ui-components.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `thymeleaf-data-passing.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `js-module-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `hybrids-component-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `hybrids-store-state.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `hybrids-ui-patterns.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-implements: details `hybrids-page-entry.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `thymeleaf-page-template.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `thymeleaf-ui-components.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `thymeleaf-data-passing.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `js-module-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `hybrids-component-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `hybrids-store-state.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `hybrids-ui-patterns.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-validate: details `hybrids-page-entry.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `thymeleaf-page-template.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `thymeleaf-ui-components.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `thymeleaf-data-passing.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `js-module-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `hybrids-component-structure.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `hybrids-store-state.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `hybrids-ui-patterns.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`
> - page-review: details `hybrids-page-entry.md` not found in `/Users/munpia/Desktop/practice/dynamic-builder/.claude/worktrees/angry-brahmagupta/.claude/skills/dynamic-workflow-builder/src/details/`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| page-analyze-A | uiux-analyst | Controller와 퍼블 HTML/CSS를 분석하여 UI/UX 관점의 화면 명세를 생성한다 |
| page-analyze-B | usecase-analyst | Controller와 퍼블 HTML/CSS를 분석하여 유스케이스 관점의 화면 명세를 생성한다 |
| page-tradeoff-advise | tradeoff-advisor | 화면 구현 방식의 트레이드오프를 조언한다 |
| page-constraint-advise | constraint-bypass-advisor | 화면 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) |
| page-scope-reduction-advise | scope-reduction-advisor | 최소 범위로 화면 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) |
| page-synthesis | scope-reduction-reconciler | 분석 및 조언 결과를 통합하여 화면 구현 방향을 결정한다 |
| page-usecase-review | usecase-evaluator | 화면 명세의 유스케이스 완전성과 사후조건을 채점하고 개선 방향을 제시한다 |
| page-uiux-review | uiux-evaluator | 화면 명세의 UX 패턴과 인터랙션 완전성을 채점하고 개선 방향을 제시한다 |
| page-plan | uiux-planner | 화면 구현 계획을 수립한다 (컴포넌트 구조, 데이터 바인딩, 이벤트 흐름) |
| page-plan-advise | scope-reduction-advisor | 화면 구현 계획의 최소 범위 접근을 조언한다 |
| page-plan-validate | uiux-validator | 화면 구현 계획의 패턴 준수와 완전성을 검증한다 (합격/불합격) |
| page-plan-review | uiux-evaluator | 검증 통과된 구현 계획의 품질을 채점하고 개선 방향을 제시한다 |
| page-implements | uiux-implementor | 화면 명세를 기반으로 Thymeleaf 템플릿과 JS 파일을 생성한다 |
| page-validate | uiux-validator | 생성된 화면 코드의 패턴 준수, 데이터 바인딩 정확성, 누락 여부를 검증한다 (합격/불합격) |
| page-review | uiux-evaluator | 검증 통과된 화면 코드의 설계 품질을 채점하고 개선 방향을 제시한다 |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 6개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - (순차 흐름):
        1. **[STEP]** `page-analyze-A`
           - desc: Controller와 퍼블 HTML/CSS를 분석하여 UI/UX 관점의 화면 명세를 생성한다
           - agent: `uiux-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/thymeleaf-guide-index.md`, `references/hybrids-guide-index.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/page-analyze-A.md`

        2. **[STEP]** `page-tradeoff-advise`
           - desc: 화면 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/page-analyze-A.md`, `.local/$ARGUMENTS/page-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/page-tradeoff-advise.md`

       - `page-constraint-advise`: 화면 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `page-scope-reduction-advise`: 최소 범위로 화면 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)
       - (순차 흐름):
        1. **[STEP]** `page-analyze-B`
           - desc: Controller와 퍼블 HTML/CSS를 분석하여 유스케이스 관점의 화면 명세를 생성한다
           - agent: `usecase-analyst` → Agent 도구의 subagent_type
           - details (필수 준수): `references/thymeleaf-guide-index.md`, `references/hybrids-guide-index.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
           - 산출물: `.local/$ARGUMENTS/page-analyze-B.md`

        2. **[STEP]** `page-tradeoff-advise`
           - desc: 화면 구현 방식의 트레이드오프를 조언한다
           - agent: `tradeoff-advisor` → Agent 도구의 subagent_type
           - input: `.local/$ARGUMENTS/page-analyze-A.md`, `.local/$ARGUMENTS/page-analyze-B.md`
           - 산출물: `.local/$ARGUMENTS/page-tradeoff-advise.md`

       - `page-constraint-advise`: 화면 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지) (agent: `constraint-bypass-advisor`)
       - `page-scope-reduction-advise`: 최소 범위로 화면 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지) (agent: `scope-reduction-advisor`)

    2. **[STEP]** `page-synthesis`
       - desc: 분석 및 조언 결과를 통합하여 화면 구현 방향을 결정한다
       - agent: `scope-reduction-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/page-analyze-A.md`, `.local/$ARGUMENTS/page-analyze-B.md`, `.local/$ARGUMENTS/page-tradeoff-advise.md`, `.local/$ARGUMENTS/page-constraint-advise.md`, `.local/$ARGUMENTS/page-scope-reduction-advise.md`
       - 산출물: `.local/$ARGUMENTS/page-synthesis.md`

    3. **[STEP]** `page-usecase-review`
       - desc: 화면 명세의 유스케이스 완전성과 사후조건을 채점하고 개선 방향을 제시한다
       - agent: `usecase-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/page-synthesis.md`
       - 산출물: `.local/$ARGUMENTS/page-usecase-review.md`

    4. **[IF]** 조건: `score >= 80`
       조건이 true일 때 실행:


   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

2. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

3. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[STEP]** `page-plan`
       - desc: 화면 구현 계획을 수립한다 (컴포넌트 구조, 데이터 바인딩, 이벤트 흐름)
       - agent: `uiux-planner` → Agent 도구의 subagent_type
       - details (필수 준수): `references/thymeleaf-page-template.md`, `references/thymeleaf-ui-components.md`, `references/thymeleaf-data-passing.md`, `references/js-module-structure.md`, `references/hybrids-component-structure.md`, `references/hybrids-store-state.md`, `references/hybrids-ui-patterns.md`, `references/hybrids-page-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/page-usecase-review.md`, `.local/$ARGUMENTS/page-uiux-review.md`
       - 산출물: `.local/$ARGUMENTS/page-plan.md`

    2. **[STEP]** `page-plan-advise`
       - desc: 화면 구현 계획의 최소 범위 접근을 조언한다
       - agent: `scope-reduction-advisor` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/page-plan.md`
       - 산출물: `.local/$ARGUMENTS/page-plan-advise.md`

    3. **[STEP]** `page-plan-validate`
       - desc: 화면 구현 계획의 패턴 준수와 완전성을 검증한다 (합격/불합격)
       - agent: `uiux-validator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/thymeleaf-page-template.md`, `references/thymeleaf-ui-components.md`, `references/thymeleaf-data-passing.md`, `references/js-module-structure.md`, `references/hybrids-component-structure.md`, `references/hybrids-store-state.md`, `references/hybrids-ui-patterns.md`, `references/hybrids-page-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/page-plan.md`, `.local/$ARGUMENTS/page-plan-advise.md`
       - 산출물: `.local/$ARGUMENTS/page-plan-validate.md`

    4. **[STEP]** `page-plan-review`
       - desc: 검증 통과된 구현 계획의 품질을 채점하고 개선 방향을 제시한다
       - agent: `uiux-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/page-plan.md`, `.local/$ARGUMENTS/page-plan-validate.md`
       - 산출물: `.local/$ARGUMENTS/page-plan-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 3회.

4. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
   - 승인 → 다음 단계로 진행
   - 피드백 → 이전 단계를 피드백과 함께 재실행

5. **[RETRY]** 조건: `score < 80`, 최대: 2회
   반복 내부 흐름:
    1. **[STEP]** `page-implements`
       - desc: 화면 명세를 기반으로 Thymeleaf 템플릿과 JS 파일을 생성한다
       - agent: `uiux-implementor` → Agent 도구의 subagent_type
       - details (필수 준수): `references/thymeleaf-page-template.md`, `references/thymeleaf-ui-components.md`, `references/thymeleaf-data-passing.md`, `references/js-module-structure.md`, `references/hybrids-component-structure.md`, `references/hybrids-store-state.md`, `references/hybrids-ui-patterns.md`, `references/hybrids-page-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/page-plan.md`, `.local/$ARGUMENTS/page-plan-review.md`
       - 산출물: `.local/$ARGUMENTS/page-implements.md`

    2. **[STEP]** `page-validate`
       - desc: 생성된 화면 코드의 패턴 준수, 데이터 바인딩 정확성, 누락 여부를 검증한다 (합격/불합격)
       - agent: `uiux-validator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/thymeleaf-page-template.md`, `references/thymeleaf-ui-components.md`, `references/thymeleaf-data-passing.md`, `references/js-module-structure.md`, `references/hybrids-component-structure.md`, `references/hybrids-store-state.md`, `references/hybrids-ui-patterns.md`, `references/hybrids-page-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - 산출물: `.local/$ARGUMENTS/page-validate.md`

    3. **[STEP]** `page-review`
       - desc: 검증 통과된 화면 코드의 설계 품질을 채점하고 개선 방향을 제시한다
       - agent: `uiux-evaluator` → Agent 도구의 subagent_type
       - details (필수 준수): `references/thymeleaf-page-template.md`, `references/thymeleaf-ui-components.md`, `references/thymeleaf-data-passing.md`, `references/js-module-structure.md`, `references/hybrids-component-structure.md`, `references/hybrids-store-state.md`, `references/hybrids-ui-patterns.md`, `references/hybrids-page-entry.md` — 에이전트는 이 파일에 정의된 지침을 반드시 따른다
       - input: `.local/$ARGUMENTS/page-implements.md`, `.local/$ARGUMENTS/page-validate.md`
       - 산출물: `.local/$ARGUMENTS/page-review.md`

   → 내부 흐름 실행 후 조건(`score < 80`)을 평가한다. true이면 반복, false이면 다음으로 진행. 최대 2회.

6. **[HITL]** 사용자에게 산출물을 보고하고 승인/피드백을 대기한다.
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
    - page-analyze-A:
        desc: "Controller와 퍼블 HTML/CSS를 분석하여 UI/UX 관점의 화면 명세를 생성한다"
        details:
          - thymeleaf-guide-index.md
          - hybrids-guide-index.md
        agent: uiux-analyst
    - page-analyze-B:
        desc: "Controller와 퍼블 HTML/CSS를 분석하여 유스케이스 관점의 화면 명세를 생성한다"
        details:
          - thymeleaf-guide-index.md
          - hybrids-guide-index.md
        agent: usecase-analyst

    - page-tradeoff-advise:
        desc: "화면 구현 방식의 트레이드오프를 조언한다"
        input:
          - page-analyze-A
          - page-analyze-B
        agent: tradeoff-advisor
    - page-constraint-advise:
        desc: "화면 구현 제약 요인과 우회 방안을 조언한다 (tradeoff 조언과 중복 방지)"
        input:
          - page-analyze-A
          - page-analyze-B
          - page-tradeoff-advise
        agent: constraint-bypass-advisor
    - page-scope-reduction-advise:
        desc: "최소 범위로 화면 요구사항을 충족하는 방안을 조언한다 (기존 조언과 중복 방지)"
        input:
          - page-analyze-A
          - page-analyze-B
          - page-tradeoff-advise
          - page-constraint-advise
        agent: scope-reduction-advisor

    - page-synthesis:
        desc: "분석 및 조언 결과를 통합하여 화면 구현 방향을 결정한다"
        input:
          - page-analyze-A
          - page-analyze-B
          - page-tradeoff-advise
          - page-constraint-advise
          - page-scope-reduction-advise
        agent: scope-reduction-reconciler

    - page-usecase-review:
        desc: "화면 명세의 유스케이스 완전성과 사후조건을 채점하고 개선 방향을 제시한다"
        input:
          - page-synthesis
        agent: usecase-evaluator
    - page-uiux-review:
        desc: "화면 명세의 UX 패턴과 인터랙션 완전성을 채점하고 개선 방향을 제시한다"
        input:
          - page-synthesis
        details:
          - thymeleaf-guide-index.md
          - hybrids-guide-index.md
        agent: uiux-evaluator

    - page-plan:
        desc: "화면 구현 계획을 수립한다 (컴포넌트 구조, 데이터 바인딩, 이벤트 흐름)"
        details:
          - thymeleaf-page-template.md
          - thymeleaf-ui-components.md
          - thymeleaf-data-passing.md
          - js-module-structure.md
          - hybrids-component-structure.md
          - hybrids-store-state.md
          - hybrids-ui-patterns.md
          - hybrids-page-entry.md
        input:
          - page-usecase-review
          - page-uiux-review
        agent: uiux-planner
    - page-plan-advise:
        desc: "화면 구현 계획의 최소 범위 접근을 조언한다"
        input:
          - page-plan
        agent: scope-reduction-advisor
    - page-plan-validate:
        desc: "화면 구현 계획의 패턴 준수와 완전성을 검증한다 (합격/불합격)"
        details:
          - thymeleaf-page-template.md
          - thymeleaf-ui-components.md
          - thymeleaf-data-passing.md
          - js-module-structure.md
          - hybrids-component-structure.md
          - hybrids-store-state.md
          - hybrids-ui-patterns.md
          - hybrids-page-entry.md
        input:
          - page-plan
          - page-plan-advise
        agent: uiux-validator
    - page-plan-review:
        desc: "검증 통과된 구현 계획의 품질을 채점하고 개선 방향을 제시한다"
        input:
          - page-plan
          - page-plan-validate
        agent: uiux-evaluator

    - page-implements:
        desc: "화면 명세를 기반으로 Thymeleaf 템플릿과 JS 파일을 생성한다"
        details:
          - thymeleaf-page-template.md
          - thymeleaf-ui-components.md
          - thymeleaf-data-passing.md
          - js-module-structure.md
          - hybrids-component-structure.md
          - hybrids-store-state.md
          - hybrids-ui-patterns.md
          - hybrids-page-entry.md
        input:
          - page-plan
          - page-plan-review
        agent: uiux-implementor

    - page-validate:
        desc: "생성된 화면 코드의 패턴 준수, 데이터 바인딩 정확성, 누락 여부를 검증한다 (합격/불합격)"
        details:
          - thymeleaf-page-template.md
          - thymeleaf-ui-components.md
          - thymeleaf-data-passing.md
          - js-module-structure.md
          - hybrids-component-structure.md
          - hybrids-store-state.md
          - hybrids-ui-patterns.md
          - hybrids-page-entry.md
        agent: uiux-validator
    - page-review:
        desc: "검증 통과된 화면 코드의 설계 품질을 채점하고 개선 방향을 제시한다"
        details:
          - thymeleaf-page-template.md
          - thymeleaf-ui-components.md
          - thymeleaf-data-passing.md
          - js-module-structure.md
          - hybrids-component-structure.md
          - hybrids-store-state.md
          - hybrids-ui-patterns.md
          - hybrids-page-entry.md
        input:
          - page-implements
          - page-validate
        agent: uiux-evaluator

flow:
  # Phase 1: 분석
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - flow:
            - page-analyze-A
            - page-tradeoff-advise
            - page-constraint-advise
            - page-scope-reduction-advise
          - flow:
            - page-analyze-B
            - page-tradeoff-advise
            - page-constraint-advise
            - page-scope-reduction-advise
        - page-synthesis
        - page-usecase-review
        - if:
            condition: score >= 80
            flow: page-uiux-review
  - hitl
  # Phase 2: 계획
  - retry:
      condition: score < 80
      max: 3
      flow:
        - page-plan
        - page-plan-advise
        - page-plan-validate
        - page-plan-review
  - hitl
  # Phase 3: 구현
  - retry:
      condition: score < 80
      max: 2
      flow:
        - page-implements
        - page-validate
        - page-review
  - hitl
```
