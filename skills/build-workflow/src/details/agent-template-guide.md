# 에이전트 템플릿 작성 가이드

## 템플릿 형식

```markdown
---
name: {perspective}-{role}
description: {한글 설명}
model: opus
disallowedTools: [Edit]    # role에 따라 조정
---

<Agent>
  <Perspective name="{perspective}"></Perspective>
  <Role name="{role}"></Role>
  <Principle name="evidence-first"></Principle>
  <Principle name="output-discipline"></Principle>
  <Principle name="scope-containment"></Principle>
  <Principle name="escalation-awareness"></Principle>
  <Principle name="context-budget-awareness"></Principle>
</Agent>
```

## 사용 가능한 Role (7개)

| Role | 행위 | disallowedTools |
|------|------|-----------------|
| analyst | 읽기 전용 분석 | [Edit] |
| planner | 실행 계획 수립 | [Edit] |
| validator | 규칙 준수 검증 (합격/불합격) | [Edit] |
| evaluator | 품질 채점 및 개선 방향 제시 | [Edit] |
| advisor | 전략적 조언 | [Edit] |
| reconciler | 복수 산출물 통합 | [Edit] |
| builder | 파일 생성/수정 | - (쓰기 필요) |
| executor | 명세 기반 실행 | - |

## 사용 가능한 Perspective (19개)

| Perspective | 초점 |
|------------|------|
| code-level | 분기·데이터 흐름·패턴 |
| usecase-design | 행위자·흐름·사전사후조건 |
| domain-driven-design | 비즈니스 개념·바운디드 컨텍스트 |
| technical-tradeoff | 선택지 비교·제약·리스크 |
| test-design | 비즈니스 기반 테스트 케이스 |
| ui-ux-design | 화면 흐름·인터랙션 |
| api-design | 인터페이스 계약 |
| application-level | 레이어 책임 |
| container-level | 배포·설정 |
| infra-level | 인프라·리소스 |
| data-driven | 데이터 모델·쿼리 |
| dba | DB 건강성·인덱싱 |
| git-history | 코드 진화·변경 영향 |
| security-driven | 위협 모델·취약점 |
| constraint-bypass | 우회·창의적 해법 |
| scope-reduction | 최소 범위 접근 |
| task-lifecycle | 작업 시작/완료 |
| workflow-design | 워크플로우 구조·제어 흐름 |
| agent-composition | 에이전트 구성·컴포넌트 조합 |

## 사용 가능한 Principle (8개)

| Principle | 핵심 |
|-----------|------|
| evidence-first | 모든 주장에 검증 가능한 근거 |
| output-discipline | 구조화된 출력, 산문 금지 |
| scope-containment | 즉시 범위에 집중 |
| escalation-awareness | 위임 시점 인식 |
| context-budget-awareness | 토큰 한도 존중 |
| root-cause-focus | 근본 원인 추적 |
| minimal-viable | 요구 충족 최소 구현 |
| competing-hypotheses | 복수 가설 유지 |

## 네이밍 규칙

- 파일명: `{perspective}-{role}.md`
- name 필드: 파일명과 동일 (확장자 제외)
- 기존 에이전트로 대체 가능하면 신규 생성하지 않는다
