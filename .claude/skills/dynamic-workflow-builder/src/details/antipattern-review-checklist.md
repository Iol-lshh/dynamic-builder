# 안티패턴 검토 체크리스트

변경된 코드에서 유지보수성과 확장성을 저해하는 안티패턴을 식별하기 위한 검토 관점.

## 검토 항목

### 1. 설계 안티패턴
- God Class: 단일 클래스에 과도한 책임 집중
- Feature Envy: 다른 클래스의 데이터를 과도하게 사용
- Shotgun Surgery: 하나의 변경이 다수 클래스 수정을 유발하는 구조
- Inappropriate Intimacy: 클래스 간 과도한 내부 접근

### 2. 구현 안티패턴
- Magic Number/String: 의미 없는 리터럴 하드코딩
- Copy-Paste Programming: 중복 로직 복사
- Long Method: 단일 메서드에 과도한 로직 (30줄 이상)
- Long Parameter List: 파라미터 4개 이상 (객체로 묶기 가능)

### 3. 제어 흐름 안티패턴
- Arrow Anti-Pattern: 중첩 if 3단계 이상
- Flag Argument: boolean 파라미터로 분기 제어
- Exception 기반 흐름 제어: 정상 로직에 try-catch 사용

### 4. 레이어 안티패턴
- Service 레이어에서 직접 HTTP 응답 생성
- Repository 레이어에서 비즈니스 로직 수행
- Controller에서 트랜잭션 관리
- Entity에서 DTO 변환 로직 포함

### 5. 테스트 안티패턴
- 테스트 간 상태 공유 (static 필드, DB 미정리)
- 과도한 mock 사용 (실제 동작과 괴리)
- 단언 없는 테스트 (실행만 하고 검증 안 함)

## 출력 형식

각 발견 항목에 대해:

| 필드 | 설명 |
|------|------|
| 심각도 | HIGH / MEDIUM / LOW |
| 위치 | 파일:라인 |
| 패턴명 | 식별된 안티패턴 이름 |
| 설명 | 왜 안티패턴인지 |
| 제안 | 리팩토링 방향 |
