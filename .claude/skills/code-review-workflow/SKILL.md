---
name: code-review-workflow
description: Workflow: code-review-workflow
---

# Workflow: code-review-workflow

> 자동 생성된 스킬입니다. 직접 수정하지 마세요.
> 소스: `~/.claude/skills/dynamic-workflow-builder/src/templates/code-review-workflow.yaml`

## 산출물 디렉토리

`.local/$ARGUMENTS`

## Steps

| Step | Agent | Description |
|------|-------|-------------|
| review-business-logic | domain-analyst | 변경된 코드를 도메인 모델 관점에서 검토한다. 비즈니스 규칙 위반, 도메인 불변조건 누락, 유비쿼터스 언어 ... |
| review-bug | code-level-analyst | 변경된 코드에서 잠재적 버그를 식별한다. null 처리, 분기 조건 오류, 예외 처리, 상태 변이, 데이터 ... |
| review-performance | code-level-analyst | 변경된 코드에서 성능 저하 요인을 식별한다. 알고리즘 복잡도, N+1 쿼리, 메모리 사용, I/O 블로킹, ... |
| review-dependency | application-level-analyst | 변경된 코드의 의존성과 복잡도를 검토한다. 레이어 경계 위반, 순환 참조, 모듈 결합도, 패키지 의존 방향을... |
| review-antipattern | code-level-analyst | 변경된 코드에서 안티패턴을 식별한다. 설계/구현/제어흐름/레이어/테스트 안티패턴을 중점 검토한다 |
| reconcile | tradeoff-reconciler | 5개 관점의 검토 결과를 통합한다. 중복 제거, 발견 항목 간 연관 관계 식별, 심각도 기준 우선순위 정렬을... |
| validate | code-level-validator | 통합된 리뷰 결과에서 치명적(CRITICAL) 이슈 존재 여부를 판정한다. CRITICAL 이슈가 1개 이상... |
| evaluate | code-level-evaluator | 통합된 리뷰 결과의 전체 코드 품질을 채점한다. 비즈니스 로직 정확성, 버그 위험도, 성능, 구조적 건전성,... |

## 실행 흐름

아래 흐름을 순서대로 실행한다. 메인 세션은 **오케스트레이션만** 담당한다.

1. **[RETRY]** 조건: `score < 80`, 최대: 3회
   반복 내부 흐름:
    1. **[PARALLEL]** 다음 5개를 동시에 실행한다 (하나의 메시지에 여러 Agent 호출):
       - `review-business-logic`: 변경된 코드를 도메인 모델 관점에서 검토한다. 비즈니스 규칙 위반, 도메인 불변조건 누락,... (agent: `domain-analyst`)
       - `review-bug`: 변경된 코드에서 잠재적 버그를 식별한다. null 처리, 분기 조건 오류, 예외 처리, 상... (agent: `code-level-analyst`)
       - `review-performance`: 변경된 코드에서 성능 저하 요인을 식별한다. 알고리즘 복잡도, N+1 쿼리, 메모리 사용,... (agent: `code-level-analyst`)
       - `review-dependency`: 변경된 코드의 의존성과 복잡도를 검토한다. 레이어 경계 위반, 순환 참조, 모듈 결합도, ... (agent: `application-level-analyst`)
       - `review-antipattern`: 변경된 코드에서 안티패턴을 식별한다. 설계/구현/제어흐름/레이어/테스트 안티패턴을 중점 검... (agent: `code-level-analyst`)

    2. **[STEP]** `reconcile`
       - desc: 5개 관점의 검토 결과를 통합한다. 중복 제거, 발견 항목 간 연관 관계 식별, 심각도 기준 우선순위 정렬을 수행한다
       - agent: `tradeoff-reconciler` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/review-business-logic.md`, `.local/$ARGUMENTS/review-bug.md`, `.local/$ARGUMENTS/review-performance.md`, `.local/$ARGUMENTS/review-dependency.md`, `.local/$ARGUMENTS/review-antipattern.md`
       - 산출물: `.local/$ARGUMENTS/reconcile.md`

    3. **[STEP]** `validate`
       - desc: 통합된 리뷰 결과에서 치명적(CRITICAL) 이슈 존재 여부를 판정한다. CRITICAL 이슈가 1개 이상이면 FAIL, 없으면 PASS
       - agent: `code-level-validator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/reconcile.md`
       - 산출물: `.local/$ARGUMENTS/validate.md`

    4. **[STEP]** `evaluate`
       - desc: 통합된 리뷰 결과의 전체 코드 품질을 채점한다. 비즈니스 로직 정확성, 버그 위험도, 성능, 구조적 건전성, 패턴 준수를 종합 평가하고 개선 방향을 제시한다
       - agent: `code-level-evaluator` → Agent 도구의 subagent_type
       - input: `.local/$ARGUMENTS/reconcile.md`, `.local/$ARGUMENTS/validate.md`
       - 산출물: `.local/$ARGUMENTS/evaluate.md`

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
    # Phase 1: 병렬 분석 (5개 관점)
    - review-business-logic:
        desc: "변경된 코드를 도메인 모델 관점에서 검토한다. 비즈니스 규칙 위반, 도메인 불변조건 누락, 유비쿼터스 언어 불일치를 식별한다"
        agent: domain-analyst
    - review-bug:
        desc: "변경된 코드에서 잠재적 버그를 식별한다. null 처리, 분기 조건 오류, 예외 처리, 상태 변이, 데이터 흐름, 외부 연동 문제를 중점 검토한다"
        details:
          - bug-review-checklist.md
        agent: code-level-analyst
    - review-performance:
        desc: "변경된 코드에서 성능 저하 요인을 식별한다. 알고리즘 복잡도, N+1 쿼리, 메모리 사용, I/O 블로킹, 불필요한 변환을 중점 검토한다"
        details:
          - performance-review-checklist.md
        agent: code-level-analyst
    - review-dependency:
        desc: "변경된 코드의 의존성과 복잡도를 검토한다. 레이어 경계 위반, 순환 참조, 모듈 결합도, 패키지 의존 방향을 식별한다"
        agent: application-level-analyst
    - review-antipattern:
        desc: "변경된 코드에서 안티패턴을 식별한다. 설계/구현/제어흐름/레이어/테스트 안티패턴을 중점 검토한다"
        details:
          - antipattern-review-checklist.md
        agent: code-level-analyst

    # Phase 2: 통합
    - reconcile:
        desc: "5개 관점의 검토 결과를 통합한다. 중복 제거, 발견 항목 간 연관 관계 식별, 심각도 기준 우선순위 정렬을 수행한다"
        input:
          - review-business-logic
          - review-bug
          - review-performance
          - review-dependency
          - review-antipattern
        agent: tradeoff-reconciler

    # Phase 3: 검증 + 평가
    - validate:
        desc: "통합된 리뷰 결과에서 치명적(CRITICAL) 이슈 존재 여부를 판정한다. CRITICAL 이슈가 1개 이상이면 FAIL, 없으면 PASS"
        input:
          - reconcile
        agent: code-level-validator
    - evaluate:
        desc: "통합된 리뷰 결과의 전체 코드 품질을 채점한다. 비즈니스 로직 정확성, 버그 위험도, 성능, 구조적 건전성, 패턴 준수를 종합 평가하고 개선 방향을 제시한다"
        input:
          - reconcile
          - validate
        agent: code-level-evaluator

flow:
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - review-business-logic
          - review-bug
          - review-performance
          - review-dependency
          - review-antipattern
        - reconcile
        - validate
        - evaluate
  - hitl
```
