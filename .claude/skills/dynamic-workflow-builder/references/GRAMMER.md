# Dynamic Workflow Builder

워크플로우 정의 파일(YAML)을 읽어 define된 step들을 flow 제어 흐름에 따라 실행한다.

## 워크플로우 정의 구조

```yaml
output-dir: .local/{작업 제목}  # optional, 기본값: .local/$ARGUMENTS

define:
  steps:
    - {step-name}:
        desc: {task description}
        agent: {agent-name}    # agents/ 에서 로드
        refs:                  # optional
          - {reference-file-path}
        input:                 # optional
          - {step-name}
        output: {file-name}    # optional, 기본값: {step-name}.md

flow:
  - {step-name}                # 순차 실행
  - parallel:                  # 병렬 실행
    - {step-name}
    - {step-name}
  - if:                        # 조건 분기
      condition: {expression}
      flow: [...]
  - retry:                     # 조건부 재시도
      condition: {expression}
      max: {number}
      flow: [...]
```

## define 섹션

step을 선언한다. step은 desc + agent 조합이다.

| 필드 | 필수 | 설명 |
|---|---|---|
| desc | Y | agent에게 전달할 task 설명 |
| agent | Y | 사용할 agent 이름 (`~/.claude/agents/` 아래) |
| refs | N | agent가 참조할 파일 목록 (`~/.claude/references/` 아래) |
| input | N | 이전 step 산출물을 입력으로 받을 step 이름 목록. 없으면 프로젝트 컨텍스트를 사용 |
| output | N | 산출물 파일명. 없으면 step 이름으로 자동 결정 (`{step-name}.md`) |

step은 재사용 가능한 블록이다. 동일 step을 flow에서 여러 번 참조할 수 있다.

```yaml
define:
  steps:
    - spec-analyze-usecase:
        desc: "자연어 요구사항을 유스케이스 관점에서 구조화된 요구사항 문서로 변환한다"
        agent: usecase-analyst
        refs:
          - usecase-guide.md
          - output-format.md
    - spec-analyze-domain:
        desc: "자연어 요구사항을 도메인 모델 관점에서 구조화된 요구사항 문서로 변환한다"
        agent: domain-analyst
        refs:
          - usecase-guide.md
    - spec-review:
        desc: "요구사항 문서의 유스케이스 완전성과 행위 흐름을 검증하고 점수를 매긴다"
        agent: usecase-critic
        input:
          - spec-analyze-usecase
          - spec-analyze-domain
```

## 산출물 규칙

### 출력 디렉토리

모든 산출물은 프로젝트의 `.local/{작업 제목}/` 에 저장한다.

- `output-dir`을 명시하면 해당 경로를 사용한다
- 명시하지 않으면 `.local/$ARGUMENTS`를 기본값으로 사용한다
- `.local/`은 `.gitignore`에 포함되어 git에 추적되지 않는다

### 파일명

step의 산출물 파일명은 **step 이름**을 그대로 사용한다: `{step-name}.md`

`output` 필드를 명시하면 해당 이름을 사용한다.

워크플로우 런타임은 step 실행 시 `$STEP_NAME`과 `$OUTPUT_DIR`을 agent에 전달한다. agent는 이를 산출물 경로로 사용한다.

```
.local/{작업 제목}/
  spec-analyze-usecase.md      ← step 이름 = 파일명
  spec-analyze-domain.md
  spec-review.md
```

이를 통해 동일 task를 병렬 실행해도 산출물이 충돌하지 않는다.

## flow 섹션

step들의 실행 순서와 조건을 기술한다. 4가지 제어 흐름 요소를 사용한다.

### flow (순차 실행)

배열의 항목을 위에서 아래로 순차 실행한다. 최상위에서는 `flow:` 키 아래 배열이 암묵적 flow이다. 중첩 시에만 명시한다.

```yaml
# 최상위 - 암묵적 flow
flow:
  - step-a
  - step-b
  - step-c

# 중첩 - 명시적 flow (parallel 안에서 순차를 표현할 때)
flow:
  - parallel:
    - step-a
    - flow:
      - step-b
      - step-c
```

### parallel (병렬 실행)

항목들을 동시에 실행하고, 모두 완료될 때까지 대기한다.

```yaml
flow:
  - parallel:
    - spec-usecase-analyze
    - spec-domain-analyze
```

### if (조건 분기)

condition이 true일 때 내부 flow를 실행한다.

```yaml
flow:
  - spec-review
  - if:
      condition: score < 80
      flow:
        - spec-domain-analyze
        - spec-review
```

### retry (조건부 재시도)

condition이 true인 동안 내부 flow를 반복 실행한다. max 횟수 도달 시 중단.

```yaml
flow:
  - spec-review
  - retry:
      condition: score < 80
      max: 2
      flow:
        - parallel:
          - spec-usecase-analyze
          - spec-domain-analyze
        - spec-review
```

## 제어 흐름 중첩

flow, parallel, if, retry는 자유롭게 중첩 가능하다.

```yaml
flow:
  - retry:
      condition: score < 80
      max: 2
      flow:
        - parallel:
          - spec-usecase-analyze
          - spec-domain-analyze
        - spec-review
```

### 제어 종류

#### hitl (Human In The Loop)

각 step 실행 후 사용자 확인을 거친다. workflow의 PRINCIPLE.md에 정의된 원칙을 따른다.

#### score expression

review 이후에 score(100점 만점) 표현식 확인을 거친다.

## 파일 구조

```
skills/dynamic-workflow-builder/
  SKILL.md                        ← skill 정의 (스크립트 실행)
  references/
    GRAMMER.md                     ← 이 파일 (워크플로우 정의 문법)
  scripts/
    build-workflow.js               ← 워크플로우 실행 스크립트
  templates/
    spec-workflow.yaml            ← 워크플로우 정의 예시
```
