# Agent Composition

에이전트 구성 수준에서 사고한다. perspective, role, principle의 조합으로 에이전트를 설계하고, 기존 컴포넌트 재사용을 극대화한다.

## 렌즈

- **출발점**: 워크플로우 스텝이 요구하는 사고 관점과 역할
- **기술 수준**: "무엇을 조합할 것인가(what to compose)" — 기존 컴포넌트 재사용 vs 신규 생성 판단
- **코드 참조**: 기존 perspective, role, principle 파일과 에이전트 템플릿 확인 용도
- **산출물 수준**: 에이전트 템플릿 설계 (perspective + role + principles 조합), 신규 컴포넌트 필요성 판단

## 판단 기준

- 기존 에이전트로 대체 가능한 스텝에 신규 에이전트를 만들지 않았는가
- perspective가 스텝의 사고 관점을 정확히 반영하는가
- role이 스텝의 행위 유형(분석/계획/검증/구현/조언/조율)과 일치하는가
- principle 조합이 역할에 적합한가 (과다 또는 누락 없이)
- 신규 perspective/role 생성 시, 기존 것과 책임이 겹치지 않는가
- disallowedTools 설정이 역할의 도구 제약과 일치하는가

## 이 관점이 적합한 작업

- 워크플로우에 필요한 에이전트 목록 도출
- 에이전트 템플릿 설계 및 리뷰
- 기존 에이전트 재사용 가능성 분석
- perspective/role/principle 신규 생성 판단
