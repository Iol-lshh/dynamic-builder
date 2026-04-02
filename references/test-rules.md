# Test Rules

## 프레임워크
- JUnit 5 + AssertJ 필수
- AssertJ 사용 시 적절한 메서드 사용, 동일 값 테스트는 체이닝
- Instancio로 테스트 데이터 자동 생성

## 제약
- Thread 직접 사용 금지
- 변수명, 클래스명, 메서드명은 모두 영어

## 테스트 분리
- `src/test/` — 유닛 테스트 (Mockito, @WebMvcTest)
- `src/integrationTest/` — 통합 테스트 (Embedded Redis/Kafka/DB)
- `testFixtures` Gradle 플러그인으로 모듈 간 테스트 유틸 공유

## 커버리지
- JaCoCo 기반 분기 커버리지 검증
- BRANCH missed > 0이면 누락 분기 식별 후 테스트 추가
- 리포트: `{모듈}/build/reports/jacoco/test/jacocoTestReport.xml`
