# 워크플로우 복잡도 선택 가이드

create-workflow-blueprint가 사용자 요구사항을 분석한 뒤, 아래 기준에 따라 적절한 복잡도 티어를 선택한다.

---

## 판단 기준

| 질문 | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|------|--------|--------|--------|--------|
| 다관점 분석이 필요한가? | 아니오 | 예 | 예 | 예 |
| 파일 생성/수정이 포함되는가? | 예 (단순) | 아니오 | 예 | 선택적 |
| 설계 단계가 필요한가? | 아니오 | 아니오 | 예 | 아니오 |
| 품질 반복(retry)이 필요한가? | 아니오 | 예 (1회) | 예 (2회 이상) | 예 (1회) |
| 사용자 입력이 분석의 핵심 소스인가? | 아니오 | 아니오 | 아니오 | 예 |

---

## Tier 1 — 단순 실행

**언제:** 명확한 입력과 명세가 이미 존재하고, 분석이나 설계 없이 바로 실행할 수 있는 작업.

**패턴:**
```yaml
flow:
  - execute
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
execute → hitl
```

---

## Tier 2 — 병렬 분석 → 통합 → 평가

**언제:** 여러 관점의 분석이 필요하지만, 파일 생성/수정 없이 분석 산출물(명세, 계획, 보고서)이 최종 결과인 작업.

**패턴:**
```yaml
flow:
  - parallel:
    - analyze-A
    - analyze-B
  - synthesize
  - retry:
      condition: score < 80
      max: 2
      flow:
        - retrospect
        - review
  - hitl
```

**특징:**
- 스텝 5~8개
- 병렬 분석 2~3개
- retrospect 통합 및 회고, 병렬 분석 결과 입력 (retry시 리뷰 결과 추가)
- review 품질 게이트, 회고 결과 입력
- retry 2회 (회고 루프)
- HITL 1개

**적합한 작업 예시:**
- 유스케이스 + 도메인 관점 요구사항 분석
- 아키텍처 의사결정 문서 작성
- 테스트 전략 수립
- API 설계 명세 도출

**스텝 구성:**
```
parallel{analyst × N} -> reconciler → retry{reconciler → evaluator} → hitl
```

---

## Tier 3 — 병렬 분석 → 통합 → 평가 → 계획 → 계획 검증 → 구현 → 구현 검증 → 구현 평가

**언제:** 분석부터 파일 생성까지 전체 라이프사이클을 커버하는 작업. 설계와 구현이 모두 필요하고, 각 단계에서 품질 게이트를 거쳐야 한다.

**패턴:**
```yaml
flow:
  # Phase 1: 분석
  - parallel:
    - analyze-A
    - analyze-B
  - synthesize
  - retry:
      condition: score < 80
      max: 2
      flow:
        - retrospect
        - review
  - hitl
  # Phase 2: 계획
  - retry:
      condition: validate false
      max: 2
      flow:
        - plan
        - plan-validate
  - hitl
  # Phase 3: 구현
  - retry:
      condition: validate false || score < 80
      max: 3
      flow:
        - build
        - parallel:
          - build-validate
          - build-review
  - hitl
```

**특징:**
- 스텝 10개 이상
- 3개 페이즈 (분석 → 설계 → 구현)
- 각 페이즈에 retry + validate 또는 evaluator
- HITL 3개 (페이즈 전환점마다)
- 다른 관점의 병렬 분석 및 반복 회고 + 평가로 품질 확보
- planner + validator로 설계 정확성 확보
- builder + validator + evaluator로 구현 정확성, 품질 확보
- 검증과 평가를 병렬 처리

**적합한 작업 예시:**
- 분석 → 설계 → 코드 생성 전체 파이프라인
- 새 워크플로우 + 에이전트 템플릿 생성 (create-workflow-blueprint)
- 새 화면 구현 (분석 → 명세 → Thymeleaf/JS 생성)
- TDD 전체 사이클 (분석 → 테스트 작성 → 구현)

**스텝 구성:**
```
Phase 1: parallel{analyst × N} -> reconciler → retry{reconciler → evaluator} → hitl
Phase 2: retry{planner → validator} → hitl
Phase 3: retry{builder → parallel{validator, evaluator}} → hitl
```

---

## Tier 4 — 인터뷰 기반 탐색 → 산출물 생성

**언제:** 입력 명세가 불완전하거나 부재하여, 사용자에게 질문을 통해 요구사항을 발굴해야 하는 작업. DDD에서 도메인 전문가 인터뷰로 도메인 모델을 발견하듯, 다관점 분석으로 질문을 도출하고 사용자 답변을 기반으로 산출물을 생성한다.

**패턴:**
```yaml
flow:
  # Phase 1: 질문지 작성
  - parallel:
      - analyze-A
      - analyze-B
  - synthesize
  # Phase 2: 반복 질의 응답
  - retry:
      condition: hitl
      flow:
        - hitl
        - retrospect
  # Phase 3: 답변 분석 → 산출물 생성
  - retry:
      condition: score < 80
      max: 2
      flow:
        - answer-analysis
        - draft
        - validate
        - review
  - hitl
```

**특징:**
- 스텝 10~12개
- 2개 페이즈 (질문 도출 → 산출물 생성)
- Phase 1: 병렬 분석으로 질문 생성 → 통합
- Phase 2: 회고 → 사용자 답변 수집
- Phase 3: 답변 분석 → 산출물 작성 → 검증 → 평가
- HITL 최소 2개 (답변 수집 + 최종 확인)
- Tier 2와 달리 **사용자 답변이 분석의 핵심 입력**

**Tier 2와의 핵심 차이:**
- Tier 2: 이미 존재하는 데이터를 다관점 분석
- Tier 4: 질문을 만들어 사용자에게서 데이터를 수집한 뒤 분석

**적합한 작업 예시:**
- 요구사항이 모호한 상태에서 리포트 작성
- 도메인 모델 발굴 (엔티티, 값객체, 애그리거트 도출)
- 사용자 인터뷰 기반 명세 작성
- 비즈니스 규칙 정리 (사용자가 암묵적으로 알고 있는 지식 명시화)

**스텝 구성:**
```
Phase 1: parallel(analyst × N) → reconciler
Phase 2: retry(사용자 만족){hitl(답변 수집) → reconciler}
Phase 3: retry{answer-analysis → draft → validate → evaluate} → hitl
```

---

## 역할 배치 규칙

각 티어에서 사용하는 role의 조합:

| 페이즈 | 사용 Role                | 목적 |
|-----|------------------------|------|
| 분석  | analyst (× N, 병렬)      | 다관점 현황 파악 |
| 통합  | reconciler (× 1)       | 분석 산출물 병합 |
| 평가  | evaluator (× 1)        | score 기반 품질 게이트 |
| 계획  | planner (× 1)          | 실행 계획 수립 |
| 구현  | builder / executor (× 1) | 파일 생성 또는 명세 실행 |
| 검증  | validator (× 1)        | 규칙 준수 합격/불합격 |
| 질문 도출 | analyst (× N, 병렬) | 사용자에게 확인할 질문 생성 |
| 답변 분석 | reconciler (× 1)       | 사용자 답변 분석 |

---

## 선택 플로우차트

```
요구사항 수신
  │
  ├─ 입력 명세가 충분하고 분석 불필요?
  │   └─ YES → Tier 1 (단순 실행)
  │
  ├─ 사용자에게 질문하여 요구사항을 발굴해야 하는가?
  │   └─ YES → Tier 4 (질문 도출 → 답변 분석 → 산출물 생성)
  │
  ├─ 파일 생성/수정이 최종 결과에 포함?
  │   ├─ NO  → Tier 2 (분석 → 통합 → 평가)
  │   └─ YES → Tier 3 (분석 → 계획 → 구현)
  │
  └─ 판단 불가 → 사용자에게 확인 (hitl)
```
