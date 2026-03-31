# 워크플로우 YAML 작성 가이드

## 필수 구조

```yaml
define:
  steps:
    - {step-name}:
        desc: "스텝 설명"
        agent: {agent-name}
        details:            # (선택) 워크플로우 로컬 가이드 파일
          - file.md
        refs:               # (선택) ~/.claude/references/ 내 참조 파일
          - file.md
        input:              # (선택) 이전 스텝 출력 또는 파일 경로
          - {prev-step-name}
        output: file.md     # (선택, 기본값: {step-name}.md)

flow:
  - {step-name}             # 순차 실행
  - parallel:               # 병렬 실행
    - {step-a}
    - {step-b}
  - retry:                  # 조건부 반복
      condition: score < 80
      max: 3
      flow:
        - {step-x}
        - {step-y}
  - hitl                    # 사용자 확인 게이트
  - if:                     # 조건 분기
      condition: score < 60
      then:
        - {step-z}
```

## 제어 흐름 요소

| 요소 | 용도 |
|------|------|
| `flow` | 순차 실행 (최상위에서 암묵적) |
| `parallel` | 동시 실행 |
| `retry` | score 조건 기반 반복 (max 필수) |
| `if` | score 조건 기반 분기 |
| `hitl` | 되돌리기 어려운 작업 전 사용자 승인 |

## 규칙

- 한 스텝 = 한 에이전트 = 한 산출물
- input은 이전 스텝명 또는 파일 경로
- parallel 내부에 flow를 중첩하여 "병렬 파이프라인" 구성 가능
- retry의 condition은 직전 evaluator 스텝의 score 표현식
- hitl은 주요 단계 전환점에 배치
