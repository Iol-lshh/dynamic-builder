# Deploy Scope Guide

빌드된 워크플로우 YAML과 에이전트 템플릿 파일을 대상 스코프 디렉토리에 배치하는 지침.

## 핵심 원칙

**배치 대상은 반드시 `{scope-root}/dynamic-builder/` 하위이다.** 글로벌 소스 디렉토리(`skills/build-workflow/src/`, `skills/build-agent/src/`)에 직접 파일을 넣으면 안 된다. 글로벌 소스는 빌드 시스템의 기본 제공 파일이며, 사용자가 생성한 워크플로우와 에이전트는 항상 `{scope-root}/dynamic-builder/` 하위에 배치한다.

## 스코프 결정

`--scope` 인자 값에 따라 `{scope-root}`를 결정한다:

| `--scope` 값 | `{scope-root}` | 예시 |
|--------------|-----------------|------|
| `auto` (기본값) | 프로젝트 안이면 `{project}/.claude/` | `/Users/user/my-project/.claude/` |
| `auto` (기본값) | 프로젝트 밖이면 `~/.claude/` | `/Users/user/.claude/` |
| `global` | 항상 `~/.claude/` | `/Users/user/.claude/` |

**프로젝트 안인지 판단**: 현재 작업 디렉토리(cwd)에서 상위로 올라가며 `.claude/` 디렉토리를 탐색한다. 찾으면 그 위치가 `{scope-root}`. 못 찾으면 `~/.claude/`.

## 배치 경로

모든 경로는 `{scope-root}/dynamic-builder/` 하위이다.

### 워크플로우 YAML

```
{scope-root}/dynamic-builder/build-workflow/src/templates/{name}.yaml
```

### 에이전트 템플릿

```
{scope-root}/dynamic-builder/build-agent/src/templates/{name}.md
```

### 새 perspective / role / principle

기존에 없는 perspective, role, principle이 설계에 포함된 경우:

```
{scope-root}/dynamic-builder/build-agent/src/perspectives/{name}.md
{scope-root}/dynamic-builder/build-agent/src/roles/{name}.md
{scope-root}/dynamic-builder/build-agent/src/principles/{name}.md
```

### 새 details

```
{scope-root}/dynamic-builder/build-workflow/src/details/{name}.md
```

## 배치 절차

1. `--scope` 값으로 `{scope-root}` 결정 (기본값: `auto`)
2. 필요한 디렉토리 생성 (mkdir -p)
3. 산출물 디렉토리(`.local/`)에서 생성된 파일을 대상 경로에 복사
4. 배치된 파일 목록을 사용자에게 보고
5. 빌드 스크립트 실행을 안내:
   - `node skills/build-agent/scripts/build-agents.js` (에이전트 빌드)
   - `node skills/build-workflow/scripts/build-workflow.js` (워크플로우 빌드)

## 잘못된 배치 예시

| 잘못된 경로 | 올바른 경로 |
|-------------|-------------|
| `skills/build-workflow/src/templates/{name}.yaml` | `{scope-root}/dynamic-builder/build-workflow/src/templates/{name}.yaml` |
| `skills/build-agent/src/templates/{name}.md` | `{scope-root}/dynamic-builder/build-agent/src/templates/{name}.md` |
| `~/.claude/agents/{name}.md` (수동 생성) | 에이전트는 템플릿으로 생성 후 빌드 스크립트로 빌드 |
| `.local/{name}/build/agents/{name}.md` | 에이전트를 `.local/`에 저장하지 않음 |

## 주의사항

- **글로벌 소스(`skills/`)에 직접 파일을 넣지 않는다** — `{scope-root}/dynamic-builder/` 하위에만 배치
- **에이전트 파일을 수동으로 `~/.claude/agents/`에 생성하지 않는다** — 템플릿을 만들고 빌드 스크립트를 실행
- 기존 파일을 덮어쓰기 전에 사용자에게 확인한다
- 빌드 스크립트는 글로벌 소스와 프로젝트 레벨 소스를 모두 탐색하여 빌드한다
