# dynamic-builder

Claude Code 빌드 시스템 플러그인. `perspective + role` 조합으로 agent를 빌드하고, YAML 워크플로우를 skill로 변환한다.

## 구조

### 플러그인 구조

```
dynamic-builder/
├── .claude-plugin/
│   └── plugin.json             ← 플러그인 매니페스트
├── skills/
│   ├── build-agent/            ← agent 빌드 시스템
│   ├── build-workflow/         ← workflow 빌드 시스템
│   ├── build/                  ← agent + workflow 통합 빌드
│   ├── clean/                  ← 빌드 산출물 삭제
│   ├── clean-worktree/         ← worktree 정리
│   └── uninstall/              ← 플러그인 제거
├── .setup/                     ← 설치/환경 구성
│   ├── hooks/
│   └── scripts/
└── references/                 ← agent가 참조하는 공통 문서
```

### 빌드 산출물 (자동 생성)

```
~/.claude/
  agents/                       ← 빌드된 agent (글로벌/기본)
  skills/
    {workflow-name}/            ← 빌드된 workflow skill (글로벌/기본)
      SKILL.md
      references/

{project}/.claude/
  agents/                       ← 빌드된 agent (프로젝트)
  skills/
    {workflow-name}/            ← 빌드된 workflow skill (프로젝트)
```

### 3-tier 스코프 체인

빌드 시 소스를 3단계로 해석한다. 같은 이름의 파일은 상위 스코프가 우선한다.

```
프로젝트 ({project}/.claude/dynamic-builder/)  ← 최우선
  ↓ fallback
글로벌 (~/.claude/dynamic-builder/)
  ↓ fallback
기본 (플러그인 내부 src/)
```

| 스코프 | 소스 위치 | 빌드 출력 |
|---|---|---|
| 프로젝트 | `{project}/.claude/dynamic-builder/build-agent/src/` | `{project}/.claude/agents/` |
| 글로벌 | `~/.claude/dynamic-builder/build-agent/src/` | `~/.claude/agents/` |
| 기본 | 플러그인 내부 `skills/build-agent/src/` | `~/.claude/agents/` |

사용자 소스 디렉토리 구조:

```
~/.claude/dynamic-builder/          # 글로벌 사용자 소스
  build-agent/
    src/perspectives/, roles/, principles/, templates/
    .build-index.local.json
  build-workflow/
    src/templates/, details/
    .build-index.local.json

{project}/.claude/dynamic-builder/  # 프로젝트 사용자 소스
  build-agent/
    src/perspectives/, roles/, principles/, templates/
    .build-index.local.json
  build-workflow/
    src/templates/, details/
    .build-index.local.json
```

실행 위치에 따른 동작:

| 실행 위치 | build | clean |
|---|---|---|
| 프로젝트 밖 | 기본+글로벌 → `~/.claude/` | 글로벌 인덱스 → `~/.claude/` 삭제 |
| 프로젝트 안 | 기본+글로벌 → `~/.claude/` + 프로젝트 → `{project}/.claude/` | 글로벌 + 프로젝트 인덱스 삭제 |

### Hooks/Settings (.setup/)

```
.setup/
  hooks/
    protect-branch-file.sh    ← 보호 브랜치 파일 수정 차단
    protect-branch-git.sh     ← 보호 브랜치 git 작업 차단
    protect-worktree-bash.sh  ← worktree 경계 밖 Bash 작업 차단
  settings.json               ← hooks 설정
```

---

## Skills

### build-agent

`perspective + role` 조합으로 agent를 빌드하는 시스템.

**빌드**

```bash
/dynamic-builder:build --agent
/dynamic-builder:build-agent
/dynamic-builder:build-agent --watch
/dynamic-builder:build-agent --clean
```

**구성 요소**

| 구성 | 경로 | 설명 |
|---|---|---|
| Perspective | `src/perspectives/` | agent가 바라보는 관점 (usecase, code-level, ...) |
| Role | `src/roles/` | agent의 담당과 행동 방식 (analyst, builder, ...) |
| Principle | `src/principles/` | agent에 추가적으로 적용시킬 행동 원칙 |
| Template | `src/templates/` | perspective + role 조합 뼈대 |

**현재 정의된 Perspective**

`agent-composition` · `api-design` · `application-level` · `apriorist` · `code-level` · `container-level` · `data-driven` · `dba` · `deconstructionist` · `domain-driven-design` · `empiricist` · `essay-synthesis` · `essay-writing` · `git-history` · `infra-level` · `scope-reduction` · `security-driven` · `task-lifecycle` · `technical-tradeoff` · `test-design` · `ui-ux-design` · `usecase-design` · `workflow-design`

**현재 정의된 Role**

| Role | 설명 |
|---|---|
| `analyst` | 읽기 전용 분석, 보고서 생성 |
| `builder` | 명세 기반 최소 구현 |
| `evaluator` | 산출물 품질 채점, 피드백 |
| `executor` | 직접 실행 (Bash, 도구 호출) |
| `planner` | 실행 계획 수립 |
| `reconciler` | 여러 관점 통합 조율 |
| `validator` | 규칙 기반 검증, 리뷰 |

**현재 정의된 Principle**

| Principle | 설명 |
|---|---|
| `competing-hypotheses` | 다중 가설 사고 |
| `context-budget-awareness` | 토큰 예산 관리 |
| `escalation-awareness` | 문제 에스컬레이션 전략 |
| `evidence-first` | 근거 기반 판단 |
| `minimal-viable` | 최소 실행 가능 접근 |
| `output-discipline` | 출력 형식 준수 |
| `root-cause-focus` | 근본 원인 분석 |
| `scope-containment` | 범위 관리 |

**새 agent 추가 (플러그인 수정 없이)**

1. `~/.claude/dynamic-builder/build-agent/src/` 아래에 필요한 perspective / role / template 추가
2. 프로젝트 전용이면 `{project}/.claude/dynamic-builder/build-agent/src/`에 추가
3. 빌드 실행 → 해당 스코프의 출력 위치에 생성됨

---

### build-workflow

YAML로 정의된 workflow를 skill로 빌드하는 시스템.

**빌드**

```bash
/dynamic-builder:build --workflow
/dynamic-builder:build-workflow
/dynamic-builder:build-workflow --watch
/dynamic-builder:build-workflow --clean
```

빌드 결과: `~/.claude/skills/{name}/SKILL.md` + `references/` (또는 프로젝트 스코프면 `{project}/.claude/skills/`)

**workflow 정의 구조**

```yaml
output-dir: .local/{작업 제목}  # 산출물 디렉토리 (기본값: .local/$ARGUMENTS)

define:
  steps:
    - step-name:
        desc: "agent에게 전달할 작업 설명"
        agent: agent-name       # ~/.claude/agents/ 에서 로드
        details:                # optional - 워크플로우 로컬 참조 (src/details/ 기준)
          - detail-file.md
        refs:                   # optional - 글로벌 참조 (~/.claude/references/ 기준)
          - reference-file.md   #   또는 경로 (./relative, /absolute)
        input:                  # optional - step 이름 또는 파일 경로
          - prev-step-name      #   step 이름 → {output-dir}/{name}.md
          - ./external-file.md  #   경로 → 그대로 사용
        output: result.md       # optional - 산출물 파일명 (기본값: {step-name}.md)

flow:
  - step-name          # 순차
  - parallel:          # 병렬
    - step-a
    - step-b
  - hitl               # 사용자 확인 대기
  - if:                # 조건 분기
      condition: score < 80
      flow:
        - step-name
  - retry:             # 조건부 재시도
      condition: score < 80
      max: 3
      flow:
        - step-name
```

**details vs refs**

| 필드 | 기준 경로 | 용도 |
|---|---|---|
| `details` | `src/details/` → 빌드 시 `references/`로 복사 | 워크플로우에 응집된 로컬 참조 |
| `refs` | `~/.claude/references/` (또는 직접 경로) | 여러 워크플로우가 공유하는 글로벌 참조 |

**현재 정의된 workflow**

| Workflow | 설명                                   |
|---|--------------------------------------|
| `spec-workflow` | 요구사항 → 유스케이스/도메인 분석 → 검증             |
| `tdd-workflow` | 트레이드오프 분석 → TDD Red/Green → 품질 검증    |
| `coverage-workflow` | 테스트 커버리지 분석 → 계획 → 구현                |
| `page-workflow` | Controller/퍼블 HTML → 화면 명세 → 구현 → 검증 |
| `code-review-workflow` | 코드 리뷰 프로세스                           |
| `report-workflow` | 문서 생성 워크플로우                          |
| `essay-analysis-workflow` | 에세이 다관점 분석                           |
| `essay-writing-workflow` | 논픽션 글쓰기 워크플로우                        |
| `create-workflow-blueprint` | **워크플로우 템플릿 생성**                     |

**새 workflow 추가 (플러그인 수정 없이)**

1. `~/.claude/dynamic-builder/build-workflow/src/templates/`에 YAML 파일 추가
2. 필요한 details 파일은 `src/details/`에 추가
3. 프로젝트 전용이면 `{project}/.claude/dynamic-builder/build-workflow/src/`에 추가
4. 빌드 실행 → 해당 스코프의 출력 위치에 생성됨

**워크플로우 생성 흐름 (`create-workflow-blueprint`)**

1. `create-workflow-blueprint` 실행 → `.local/{인자}/`에 워크플로우 YAML·에이전트 템플릿 설계 문서 생성
2. 사용자가 검토 후 적절한 스코프의 `src/templates/`, `src/perspectives/` 등에 배치
3. `/dynamic-builder:build` 실행 → 빌드 반영

---

## Hooks

보호 브랜치(`main*`, `master*`, `dev*`, `stag*`, `rc*`)에서 직접 작업을 차단한다.

| Hook | 차단 대상 |
|---|---|
| `protect-branch-file.sh` | `Edit`, `Write`, `MultiEdit` — 파일 수정 |
| `protect-branch-git.sh` | `git commit`, `push`, `merge`, `rebase`, `reset` |
| `protect-worktree-bash.sh` | worktree 경계 밖 Bash 작업 |

차단 시 `/worktree-entry-workflow`로 worktree를 생성하도록 안내한다.

---

## 스킬 커맨드

| 커맨드 | 설명 | 주요 옵션 |
|---|---|---|
| `/dynamic-builder:build` | agent + workflow 통합 빌드 | `--agent`, `--workflow` |
| `/dynamic-builder:clean` | 빌드 산출물 삭제 | `--agent`, `--workflow` |
| `/dynamic-builder:clean-worktree` | worktree 및 연결 브랜치 삭제 | `--all`, `--prunable`, `--dry-run`, `<name>` |
| `/dynamic-builder:build-agent` | agent 빌드 스킬 | `--watch`, `--clean` |
| `/dynamic-builder:build-workflow` | workflow 빌드 스킬 | `--watch`, `--clean` |
| `/dynamic-builder:uninstall` | 플러그인 완전 제거 | `--force` |

---

## 설치

### 플러그인으로 설치 (권장)

```bash
git clone https://github.com/Iol-lshh/dynamic-builder.git
cd dynamic-builder
bash .setup/scripts/install.sh            # 전체 설치 (각 단계 확인)
bash .setup/scripts/install.sh --force    # 확인 없이 전체 설치
```

개별 설치:

```bash
bash .setup/scripts/install.sh --plugin   # 플러그인만
bash .setup/scripts/install.sh --settings # hooks/settings만
bash .setup/scripts/install.sh --build    # 빌드만
```

설치 후 스킬 사용:

```
/dynamic-builder:build
/dynamic-builder:build-agent
/dynamic-builder:build-workflow
```

### 제거

```bash
bash .setup/scripts/uninstall.sh          # 대화형 확인 후 제거
bash .setup/scripts/uninstall.sh --force  # 확인 없이 제거
```

또는 설치된 상태에서: `/dynamic-builder:uninstall`
