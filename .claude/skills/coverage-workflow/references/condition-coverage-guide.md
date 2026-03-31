# Condition Coverage 가이드

## 개요

이 프로젝트에서는 모든 분기 조건의 true/false 양쪽 경로에 대한 테스트를 요구한다.
spec-review, tdd-refactor 단계에서 주요하게 검증됨.

## 대상 분기 유형

### 1. if/else, switch/case
```java
if (novelSources.isEmpty()) {   // true: 빈 리스트 / false: 요소 있음
    return;
}
```
→ 테스트 2개: 빈 리스트일 때 + 요소 있을 때

### 2. 삼항 연산자
```java
String value = isAdult ? "Y" : "N";  // true: 성인 / false: 비성인
```
→ 테스트 2개: isAdult=true + isAdult=false

### 3. && / || (short-circuit)
```java
if (a != null && a.isValid()) {  // 조건 2개 × true/false
```
→ 테스트 3개: a=null (&&에서 short-circuit) / a!=null&&valid / a!=null&&!valid

### 4. Optional 분기
```java
optional.map(this::transform).orElse(defaultValue);
// present: transform 실행 / empty: defaultValue 반환
```
→ 테스트 2개: Optional.of(value) + Optional.empty()

### 5. Stream 내부 조건
```java
list.stream()
    .filter(item -> item.isActive())  // true: 포함 / false: 제외
    .map(item -> item.getName())
    .toList();
```
→ 테스트: 모두 active / 모두 inactive / 혼합

### 6. 예외 발생 조건
```java
default -> throw new IllegalStateException("Unexpected: " + item);
```
→ 테스트: 정상 케이스 + 예외 발생 케이스

### 7. Specification 패턴
```java
public boolean isSatisfiedBy(SearchRequest.WithPolicy<?> statement) {
    return statement.requester().isAdult();  // true/false
}
```
→ 테스트 2개: 조건 충족 + 조건 미충족

## Condition Coverage Map 형식

spec-review에서 출력하는 형식:

| 조건 (파일:라인) | true 경로 테스트 | false 경로 테스트 |
|---|---|---|
| `NovelPipelineProcessor.java:37` novelSources.isEmpty() | 원천 데이터 없으면 조기 반환 | 원천 데이터 있으면 파이프라인 진행 |
| `SearchRequestBlockSpec.java:25` isAdult() | 성인 검색 허용 | 성인 검색 차단 |

## 커버리지 리포트 확인

```bash
./gradlew build jacocoTestReport
# 리포트 위치: build/reports/jacoco/test/html/index.html
```