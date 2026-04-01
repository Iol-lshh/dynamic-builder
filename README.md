# dynamic-builder

Claude Code 개인 설정 저장소. `~/.claude/`에 복사하여 사용한다.

## 구조

```
.claude/
  skills/
    dynamic-agent-builder/    ← agent 빌드 시스템
    dynamic-workflow-builder/ ← workflow 빌드 시스템
    {workflow-name}/          ← 빌드된 workflow skill (자동 생성)
      SKILL.md
      references/             ← details 파일 복사본 (자동 생성)
  hooks/
    protect-branch-file.sh    ← 보호 브랜치 파일 수정 차단
    protect-branch-git.sh     ← 보호 브랜치 git 작업 차단
    protect-worktree-bash.sh  ← worktree 경계 밖 Bash 작업 차단
  scripts/
    build-dynamic.sh          ← agent + workflow 통합 빌드
    clean-dynamic.sh          ← 빌드 산출물 정리
    clean-worktree.sh         ← worktree 정리
  agents/                     ← 빌드된 agent (자동 생성)
  references/                 ← agent가 참조하는 공통 문서
  settings.json               ← hooks 설정
```

---

## Skills

### dynamic-agent-builder

`perspective + role` 조합으로 agent를 빌드하는 시스템.

**빌드**

```bash
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js --watch
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js --clean
```

**구성 요소**

| 구성 | 경로 | 설명 |
|---|---|---|
| Perspective | `src/perspectives/` | agent가 바라보는 관점 (usecase, code-level, ...) |
| Role | `src/roles/` | agent의 담당과 행동 방식 (analyst, builder, ...) |
| Principle | `src/principles/` | agent에 추가적으로 적용시킬 행동 원칙 |
| Template | `src/templates/` | perspective + role 조합 뼈대 |

**현재 정의된 Perspective**

`agent-composition` · `api-design` · `application-level` · `apriorist` · `code-level` · `constraint-bypass` · `container-level` · `data-driven` · `dba` · `deconstructionist` · `domain-driven-design` · `empiricist` · `essay-synthesis` · `git-history` · `infra-level` · `nonfiction-writing` · `scope-reduction` · `security-driven` · `task-lifecycle` · `technical-tradeoff` · `test-design` · `ui-ux-design` · `usecase-design` · `workflow-design`

**현재 정의된 Role**

| Role | 설명 |
|---|---|
| `analyst` | 읽기 전용 분석, 보고서 생성 |
| `advisor` | 트레이드오프 조언 |
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

**새 agent 추가**

1. 필요한 perspective / role이 없으면 `src/` 에 추가
2. `src/templates/{perspective}-{role}.md` 뼈대 생성
3. 빌드 실행 → `~/.claude/agents/` 에 생성됨

---

### dynamic-workflow-builder

YAML로 정의된 workflow를 skill로 빌드하는 시스템.

**빌드**

```bash
node ~/.claude/skills/dynamic-workflow-builder/scripts/build-workflow.js
node ~/.claude/skills/dynamic-workflow-builder/scripts/build-workflow.js --watch
node ~/.claude/skills/dynamic-workflow-builder/scripts/build-workflow.js --clean
```

빌드 결과: `~/.claude/skills/{name}/SKILL.md` + `references/`

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

| Workflow | 설명 |
|---|---|
| `spec-workflow` | 요구사항 → 유스케이스/도메인 분석 → 검증 |
| `tdd-workflow` | 트레이드오프 분석 → TDD Red/Green → 품질 검증 |
| `coverage-workflow` | 테스트 커버리지 분석 → 계획 → 구현 |
| `page-workflow` | Controller/퍼블 HTML → 화면 명세 → 구현 → 검증 |
| `code-review-workflow` | 코드 리뷰 프로세스 |
| `report-workflow` | 문서 생성 워크플로우 |
| `essay-analysis-workflow` | 에세이 다관점 분석 |
| `nonfiction-writing-workflow` | 논픽션 글쓰기 워크플로우 |
| `create-workflow-blueprint` | 워크플로우 템플릿 생성 |
| `worktree-entry-workflow` | 작업 시작 시 git worktree 생성 및 세션 전환 |
| `worktree-close-workflow` | 작업 종료 시 worktree 정리 및 복귀 |

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

## 설치

```bash
git clone https://github.com/Iol-lshh/dynamic-builder.git
cp -r dynamic-builder/.claude/* ~/.claude/
```

빌드:

```bash
# 통합 빌드
~/.claude/scripts/build-dynamic.sh

# 개별 빌드
node ~/.claude/skills/dynamic-agent-builder/scripts/build-agents.js
node ~/.claude/skills/dynamic-workflow-builder/scripts/build-workflow.js
```
