# Code Patterns & Conventions

## Class Role Naming

| 접미사 | 위치 | 역할                                                                                                                                                                                    |
|---|---|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Entity** | core | 동일성을 갖는 핵심 비즈니스 모델 객체                                                                                                                                        |
| **Info** | core | Projection된 비즈니스 모델 객체                                                                                                                                            |
| **Request** | core | 비즈니스 로직의 질의/실행 조건 객체                                                                                                                                                                  |
| **Dto** | client/api | 외부 통신 (request/response), 버전 관리                                                                                                                                                       |
| **Processor** | core | 도메인 비즈니스 로직 실행 단위. Spring 의존 없이 순수 로직 처리. 외부 의존은 Function 파라미터로 주입받음                                                 |
| **Specification** | core | 비즈니스 규칙의 충족 여부를 판단하는 술어 객체. `Specification<T>` 인터페이스 구현, `isSatisfiedBy(T)` 메서드로 조건 평가. `and()` 조합 지원                   |
| **Service** | app 모듈 | 단일 책임의 애플리케이션 서비스.                                                                                                                         |
| **FacadeService** | app 모듈 | 여러 Service를 조합하여 유스케이스를 구성하는 퍼사드. Controller/Consumer에서 직접 호출하는 진입점                                                   |
| **DtoMapper** | 각 모듈 mapper/ | 계층의 Dto 객체 변환을 담당하는 유틸리티 클래스. `private` 생성자 + `static` 메서드. 내부에 `Request`/`Response` <br/>inner class로 방향 분리 |

## DtoMapper 구조 패턴

```java
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class XxxDtoMapper {
    @NoArgsConstructor(access = AccessLevel.PRIVATE)
    public static class Request {
        public static TargetDto convert(SourceStatement statement) { ... }
    }

    @NoArgsConstructor(access = AccessLevel.PRIVATE)
    public static class Response {
        public static DomainInfo convert(ExternalDto dto) { ... }
    }
}
```

## Processor 의존성 주입 패턴

Processor는 Spring Bean이 아닌 순수 객체. 외부 의존은 `Function` 파라미터로 주입:

```java
// core (순수 도메인)
public class NovelPipelineProcessor {
    public void execute(
        NovelPipelineRequest.Save statement,
        Function<Set<Long>, List<NovelSourceInfo.Novel>> findNovelByIds,
        Function<NovelSinkRequest.Save, Integer> saveNovel
    ) { ... }
}

// app 모듈 (FacadeService에서 호출 시 인프라 바인딩)
processor.execute(statement, sourceService::find, sinkService::save);
```
