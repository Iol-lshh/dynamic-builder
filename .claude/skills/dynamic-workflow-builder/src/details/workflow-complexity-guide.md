# 워크플로우 복잡도 선택 가이드

create-workflow-blueprint가 사용자 요구사항을 분석한 뒤, 아래 기준에 따라 적절한 복잡도 티어를 선택한다.

---

## 판단 기준

| 질문 | Tier 1 | Tier 2 | Tier 3 |
|------|--------|--------|--------|
| 다관점 분석이 필요한가? | 아니오 | 예 | 예 |
| 파일 생성/수정이 포함되는가? | 예 (단순) | 아니오 | 예 |
| 설계 단계가 필요한가? | 아니오 | 아니오 | 예 |
| 품질 반복(retry)이 필요한가? | 아니오 | 예 (1회) | 예 (2회 이상) |

---

## Tier 1 — 단순 실행

**언제:** 명확한 입력과 명세가 이미 존재하고, 분석이나 설계 없이 바로 실행할 수 있는 작업.

**패턴:**
```yaml
flow:
  - execute
  - review
  - hitl
```

**특징:**
- 스텝 2~3개
- 병렬 없음
- retry 없거나 1회
- HITL 최대 1개

**적합한 작업 예시:**
- 이미 작성된 명세를 코드로 변환
- 단일 관점의 코드 리뷰
- 기존 템플릿에 데이터만 채워서 생성

**스텝 구성:**
```
execute (builder/executor) → review (evaluator) → hitl
```

---

## Tier 2 — 병렬 분석 → 통합 → 평가

**언제:** 여러 관점의 분석이 필요하지만, 파일 생성/수정 없이 분석 산출물(명세, 계획, 보고서)이 최종 결과인 작업.

**패턴:**
```yaml
flow:
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - analyze-A
          - analyze-B
        - parallel:
          - advise-X
          - advise-Y
          - advise-Z
        - synthesize
        - review
  - hitl
```

**특징:**
- 스텝 5~8개
- 병렬 분석 2~3개
- 병렬 조언 2~3개 (tradeoff / constraint-bypass / scope-reduction)
- reconciler로 통합
- evaluator로 품질 게이트
- retry 1회 (분석 루프)
- HITL 1개

**적합한 작업 예시:**
- 유스케이스 + 도메인 관점 요구사항 분석
- 아키텍처 의사결정 문서 작성
- 테스트 전략 수립
- API 설계 명세 도출

**스텝 구성:**
```
parallel(analyst × N) → parallel(advisor × 3) → reconciler → evaluator → hitl
```

---

## Tier 3 — 병렬 분석 → 통합 → 설계 → 구현 → 검증

**언제:** 분석부터 파일 생성까지 전체 라이프사이클을 커버하는 작업. 설계와 구현이 모두 필요하고, 각 단계에서 품질 게이트를 거쳐야 한다.

**패턴:**
```yaml
flow:
  # Phase 1: 분석
  - retry:
      condition: score < 80
      max: 3
      flow:
        - parallel:
          - analyze-A
          - analyze-B
        - parallel:
          - advise-X
          - advise-Y
          - advise-Z
        - synthesize
        - review
  - hitl
  # Phase 2: 설계
  - retry:
      condition: score < 80
      max: 3
      flow:
        - plan
        - parallel:
          - plan-advise
          - plan-review
  - hitl
  # Phase 3: 구현
  - retry:
      condition: score < 80
      max: 3
      flow:
        - build
        - validate
        - build-review
  - hitl
```

**특징:**
- 스텝 10개 이상
- 3개 페이즈 (분석 → 설계 → 구현)
- 각 페이즈에 retry + evaluator
- HITL 2~3개 (페이즈 전환점마다)
- 병렬 분석 + 병렬 조언
- planner + advisor로 설계 품질 확보
- builder + validator + evaluator로 구현 품질 확보

**적합한 작업 예시:**
- 분석 → 설계 → 코드 생성 전체 파이프라인
- 새 워크플로우 + 에이전트 템플릿 생성 (create-workflow-blueprint)
- 새 화면 구현 (분석 → 명세 → Thymeleaf/JS 생성)
- TDD 전체 사이클 (분석 → 테스트 작성 → 구현)

**스텝 구성:**
```
Phase 1: parallel(analyst × N) → parallel(advisor × 3) → reconciler → evaluator → hitl
Phase 2: planner → parallel(advisor, evaluator) → hitl
Phase 3: builder → validator → evaluator → hitl
```

---

## 역할 배치 규칙

각 티어에서 사용하는 role의 조합:

| 페이즈 | 사용 Role | 목적 |
|--------|-----------|------|
| 분석 | analyst (× N, 병렬) | 다관점 현황 파악 |
| 조언 | advisor (× 3, 병렬) | tradeoff · constraint · scope-reduction |
| 통합 | reconciler (× 1) | 분석 + 조언 산출물 병합 |
| 평가 | evaluator (× 1) | score 기반 품질 게이트 |
| 설계 | planner (× 1) | 실행 계획 수립 |
| 구현 | builder / executor (× 1) | 파일 생성 또는 명세 실행 |
| 검증 | validator (× 1) | 규칙 준수 합격/불합격 |

**조언 3인방 (Tier 2, 3 공통):**
- `tradeoff-advisor` — 선택지 비교, 장단점
- `constraint-bypass-advisor` — 제약 식별, 우회 방안
- `scope-reduction-advisor` — 최소 범위 접근

---

## 선택 플로우차트

```
요구사항 수신
  │
  ├─ 입력 명세가 충분하고 분석 불필요?
  │   └─ YES → Tier 1 (단순 실행)
  │
  ├─ 파일 생성/수정이 최종 결과에 포함?
  │   ├─ NO  → Tier 2 (분석 → 통합 → 평가)
  │   └─ YES → Tier 3 (분석 → 설계 → 구현)
  │
  └─ 판단 불가 → 사용자에게 확인 (hitl)
```
