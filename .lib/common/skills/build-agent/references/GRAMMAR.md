# Dynamic Agent Builder

`templates/`의 뼈대 파일에서 XML 태그를 `src/` 내용으로 치환하여 `agents/build/`에 완성된 agent 정의 파일을 생성하는 빌드 시스템.

## 동작 원리

### 빌드 파이프라인

```
templates/{name}.md  ──→  build-agents.js  ──→  agents/build/{name}.md
                              ↑
                          src/ 내용 주입
```

1. `templates/` 디렉토리의 `.md` 파일을 순회한다
2. 각 파일의 frontmatter를 파싱하여 메타데이터(name, description, model, disallowedTools)를 추출한다
3. 본문의 XML 태그를 `src/` 디렉토리의 대응하는 파일 내용으로 치환한다
4. frontmatter + 치환된 본문을 결합하여 `agents/build/`에 완성된 agent 파일을 출력한다

### XML 태그 → src 파일 매핑

| XML 태그 | 소스 경로 |
|---|---|
| `<Perspective name="X"></Perspective>` | `src/perspectives/X.md` |
| `<Role name="X"></Role>` | `src/roles/X.md` |
| `<Principle name="X"></Principle>` | `src/principles/X.md` |

빌드 후 빈 태그가 내용이 채워진 태그로 변환된다:

```markdown
<!-- 빌드 전 (template) -->
<Perspective name="usecase-design"></Perspective>

<!-- 빌드 후 (agents/build) -->
<Perspective name="usecase-design">
# Usecase Design
유스케이스 수준에서 사고한다. 행위자가 시스템과 상호작용하여 ...
</Perspective>
```

### 실행 방법

```bash
# 일회성 빌드
node __AGENT_HOME__/skills/build-agent/scripts/build-agents.js

# watch 모드 — src/ 또는 templates/ 변경 시 자동 재빌드
node __AGENT_HOME__/skills/build-agent/scripts/build-agents.js --watch
```

## 디렉토리 구조

```
skills/build-agent/
  SKILL.md                        ← 스킬 정의 (Claude Code가 읽는 진입점)
  references/
    README.md                     ← 이 파일 (agent 구성 체계 + 빌드 시스템 설명)
  src/                            ← 조합 요소 (빌드 시 주입되는 원본)
    perspectives/*.md             ← 관점 정의
    roles/*.md                    ← 역할 정의 + 역할별 원칙 내장
    principles/*.md               ← 공통 원칙
  templates/                       ← 조합 뼈대 (직접 편집 대상)
    {perspective}-{role}.md
  scripts/
    build-agents.js               ← 빌드 스크립트

agents/
  build/                          ← 빌드 결과물 (자동 생성, 편집 금지)
    {perspective}-{role}.md
```

## 병렬 활용 원칙

동일한 role에 다른 perspective를 적용하여 병렬 실행하면, 각 관점에서 상호 보완적인 결과를 얻을 수 있다. 병렬 결과는 reconciler role이 merge한다.

```
usecase-analyst  ──→  유스케이스 수준 분석
domain-analyst   ──→  도메인 모델 수준 분석
                        ↓
                  reconciler가 merge
```

## src 작성법

`src/` 디렉토리에는 세 종류의 구성 요소가 있다. role 파일은 frontmatter로 default 옵션을 선언할 수 있고, perspective와 principle 파일은 순수 마크다운으로 작성한다.

### Perspective (`src/perspectives/`)

agent가 세상을 보는 렌즈. 어떤 추상화 수준에서 사고할지 결정한다.

**필수 섹션:**

```markdown
# {Perspective 이름}

{한 줄 요약 — 이 관점이 무엇에 집중하는지}

## 렌즈

- **출발점**: {사고의 시작점}
- **기술 수준**: {what/why/how 중 어디에 위치하는지}
- **코드 참조**: {코드를 어떤 용도로 참조하는지}
- **산출물 수준**: {이 관점의 산출물 추상화 수준}

## 판단 기준

- {이 관점에서의 옳고 그름을 구분하는 기준들}

## 이 관점이 적합한 작업

- {이 관점이 효과적인 작업 유형}
```

**예시** (`src/perspectives/usecase-design.md`):

```markdown
# Usecase Design

유스케이스 수준에서 사고한다. 행위자가 시스템과 상호작용하여 목표를 달성하는 흐름에 집중한다.

## 렌즈

- **출발점**: 행위자(actor)의 목표와 트리거
- **기술 수준**: "무엇을(what)" — 시스템이 어떤 행위를 수행하는가
- **코드 참조**: 실현 가능성 확인 용도. 흐름의 출발점이 아님
- **산출물 수준**: 기본 흐름, 확장 흐름, 사전/사후 조건

## 판단 기준

- 하나의 유스케이스 = 하나의 기본 흐름
- 트리거, 주 행위자, 사후 조건이 다르면 별개의 유스케이스
- ...

## 이 관점이 적합한 작업

- 요구사항 분석
- 테스트 명세에서 비즈니스 행위 기반 케이스 도출
```

### Role (`src/roles/`)

agent가 무엇을 담당하고 어떻게 행동하는지 정의한다. role 파일은 frontmatter로 **default 옵션**을 선언할 수 있다.

**구조:**

```markdown
---
model: {opus | sonnet | haiku}
effort: {low | medium | high | max}
maxTokens: {숫자}
disallowedTools: [{금지 도구 목록}]
---

# Role: {역할 이름}

{한 줄 요약}

## 담당
...
```

**frontmatter 필드 (모두 선택):**

| 필드 | 설명 | 예시 |
|---|---|---|
| `model` | 이 role의 기본 모델 | `sonnet` |
| `effort` | 이 role의 기본 reasoning effort | `high` |
| `maxTokens` | 이 role의 기본 최대 출력 토큰 | `2000` |
| `disallowedTools` | 이 role의 기본 금지 도구 | `[Edit]` |

role frontmatter는 **default**이며, template frontmatter가 **override**한다. 상세 규칙은 [Frontmatter 오버라이드 규칙](#frontmatter-오버라이드-규칙)을 참고한다.

**필수 섹션:**

```markdown
# Role: {역할 이름}

{한 줄 요약}

## 담당

- {이 역할이 수행하는 것}

## 담당하지 않음

- {명시적으로 수행하지 않는 것 — 다른 role과의 경계}

## 도구 제약

- {사용 가능/불가능한 도구 제약}

## 산출물

- {이 역할의 산출물 형태와 기준}

## 원칙

### {원칙 이름}
{설명}
- {세부 규칙}
```

**현재 정의된 role:**

| Role | 요약 | model | effort | maxTokens |
|---|---|---|---|---|
| `analyst` | 요구사항 분석, 보고서 생성 (읽기 전용) | sonnet | high | - |
| `planner` | 실행 계획 수립 | sonnet | medium | - |
| `reconciler` | 복수 산출물 통합·조율 | sonnet | medium | - |
| `validator` | 산출물 규칙 준수 여부 검증, 합격/불합격 판정 | haiku | low | 2000 |
| `builder` | 명세/테스트 기반 최소 구현 | haiku | low | - |
| `evaluator` | 산출물 품질 채점, 개선 방향 제시 | sonnet | medium | 4000 |
| `executor` | 주어진 작업 직접 실행 | haiku | low | - |

### Principle (`src/principles/`)

perspective/role과 무관하게 모든 agent에 공통 적용되는 행동 규칙.

```markdown
### {원칙 이름}
{설명}
- {규칙 1}
- {규칙 2}
- {규칙 3}
```

**공통 행동 특성** — 모든 agent가 perspective/role과 무관하게 따르는 행동 규칙:

### Evidence First
모든 주장에 검증 가능한 근거를 첨부한다.
- 출처, 위치, 실행 결과 등 검증 가능한 근거를 제시한다
- "probably", "seems", "might" 사용 금지
- 근거 없이 판단하지 않는다

### Output Discipline
산출물을 구조화된 형식으로 출력한다.
- 산문이 아닌 구조화된 섹션으로 출력한다
- 모호한 부분, 패턴 이탈은 반드시 사용자가 인지 가능하게 명시한다
- Final Checklist로 완전성을 자가 검증한다

### Scope Containment
할당된 범위를 엄격히 지키고 범위 확대를 방지한다.
- 요청된 범위 내에서만 작업한다
- "하는 김에" 인접 영역의 이슈를 수정하지 않는다
- 범위를 넘는 발견은 보고하되 직접 처리하지 않는다

### Escalation Awareness
자신의 역할 범위를 벗어나는 문제를 인식하고 적절한 전문가에게 위임한다.
- 역할 경계를 인식하고 넘지 않는다
- 자신이 해결할 수 없는 문제는 전체 컨텍스트와 함께 에스컬레이션한다
- 다른 역할의 전문성이 필요한 판단을 대신하지 않는다

### Context Budget Awareness
컨텍스트를 제한된 자원으로 인식하고 효율적으로 사용한다.
- 대량 입력을 처리하기 전에 먼저 구조를 파악한다
- 불필요한 정보에 컨텍스트를 소비하지 않고 관련 정보만 취한다
- 탐색 범위를 먼저 좁힌 뒤 상세 분석에 들어간다

## template 작성법

`templates/` 파일은 agent의 뼈대로, frontmatter + XML 태그 조합으로 구성한다.

### 파일명 규칙

`{perspective}-{role}.md` 형식을 따른다.

예: `usecase-analyst.md`, `domain-analyst.md`, `code-level-implementor.md`

### 구조

```markdown
---
name: {agent 이름}
description: {한 줄 설명}
model: {opus | sonnet | haiku}
disallowedTools: [{금지 도구 목록}]
---

<Agent>
  <Perspective name="{perspective 파일명 (확장자 제외)}"></Perspective>
  <Role name="{role 파일명 (확장자 제외)}"></Role>
  <Principle name="{principle 파일명 (확장자 제외)}"></Principle>
</Agent>
```

### Frontmatter 필드

| 필드 | 필수 | 설명 |
|---|---|---|
| `name` | O | agent 이름. 빌드 결과 파일명에도 사용 |
| `description` | O | agent의 한 줄 설명 |
| `model` | - | 사용할 모델 (override) |
| `effort` | - | reasoning effort (override) |
| `maxTokens` | - | 최대 출력 토큰 (override) |
| `disallowedTools` | - | 금지할 도구 목록 (override) |

`name`과 `description`은 template에서만 정의한다. 나머지 필드는 role의 default를 상속하며, template에 명시하면 override한다.

### Frontmatter 오버라이드 규칙

빌드 시 agent의 frontmatter는 **role default → template override** 순서로 결정된다.

```
role frontmatter (default)  →  template frontmatter (override)  →  agent frontmatter (결과)
```

- template에 필드가 없으면 role의 값을 사용한다
- template에 필드가 있으면 role의 값을 덮어쓴다
- `name`, `description`은 항상 template에서 가져온다

**예시:**

role (`validator.md`):
```yaml
---
model: haiku
effort: low
maxTokens: 2000
disallowedTools: [Edit]
---
```

template (`code-level-validator.md`) — override 없음:
```yaml
---
name: code-level-validator
description: 코드 구현 관점에서 산출물을 검증하는 검증자.
---
```

빌드 결과 (`agents/code-level-validator.md`):
```yaml
---
name: code-level-validator
description: 코드 구현 관점에서 산출물을 검증하는 검증자.
model: haiku          ← role default
effort: low           ← role default
maxTokens: 2000       ← role default
disallowedTools: [Edit]  ← role default
---
```

template (`security-driven-validator.md`) — model override:
```yaml
---
name: security-driven-validator
description: 보안 관점에서 산출물을 검증하는 리뷰어.
model: sonnet
---
```

빌드 결과 (`agents/security-driven-validator.md`):
```yaml
---
name: security-driven-validator
description: 보안 관점에서 산출물을 검증하는 리뷰어.
model: sonnet         ← template override
effort: low           ← role default
maxTokens: 2000       ← role default
disallowedTools: [Edit]  ← role default
---
```

### 조합 규칙

- **Perspective**: 반드시 1개만
- **Role**: 반드시 1개만
- **Principle**: 1개 이상 (보통 `common`은 항상 포함)

### 예시

**분석가 (role default 사용)**:

```markdown
---
name: usecase-analyst
description: 유스케이스 관점에서 요구사항을 분석하는 분석가. 행위자·흐름·사전사후조건 중심.
---

<Agent>
  <Perspective name="usecase-design"></Perspective>
  <Role name="analyst"></Role>
  <Principle name="common"></Principle>
</Agent>
```

→ analyst role의 default (`model: sonnet`, `effort: high`, `disallowedTools: [Edit]`)가 적용된다.

**구현자 (role default 사용)**:

```markdown
---
name: code-level-builder
description: 코드 구현 관점에서 최소한의 산출물을 작성하는 구현자. TDD GREEN·패턴 일치 중심.
---

<Agent>
  <Perspective name="code-level"></Perspective>
  <Role name="builder"></Role>
  <Principle name="common"></Principle>
</Agent>
```

→ builder role의 default (`model: haiku`, `effort: low`)가 적용된다.

**특정 agent만 override**:

```markdown
---
name: security-driven-analyst
description: 보안 관점에서 위협과 취약점을 분석하는 분석가.
model: opus
---

<Agent>
  <Perspective name="security-driven"></Perspective>
  <Role name="analyst"></Role>
  <Principle name="common"></Principle>
</Agent>
```

→ analyst role default에서 `model`만 opus로 override된다.

## 새 agent 추가 절차

1. 필요한 perspective가 `src/perspectives/`에 없으면 새로 작성한다
2. 필요한 role이 `src/roles/`에 없으면 새로 작성한다
3. `templates/`에 `{perspective}-{role}.md` 뼈대 파일을 생성한다
4. 빌드를 실행한다: `node scripts/build-agents.js`
5. `agents/build/`에 생성된 결과를 확인한다

## 주의사항

- `agents/build/`의 파일을 직접 수정하지 않는다. 항상 `src/` 또는 `templates/`을 수정하고 재빌드한다
- perspective와 role은 각각 1개만 조합한다. 복수 조합은 지원하지 않는다
- XML 태그의 `name` 속성값은 `src/` 내 파일명(확장자 제외)과 정확히 일치해야 한다