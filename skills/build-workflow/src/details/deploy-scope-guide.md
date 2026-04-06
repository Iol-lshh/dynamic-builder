# Deploy Scope Guide

빌드된 워크플로우 YAML과 에이전트 템플릿 파일을 대상 스코프 디렉토리에 배치하는 지침.

## 스코프 결정

`--scope` 인자 값에 따라 배치 대상을 결정한다:

- `--scope global` → `~/.claude/dynamic-builder/`
- `--scope auto` (기본값) → 가장 가까운 `.claude/` 디렉토리 위치
  - 프로젝트 안이면 `{project}/.claude/dynamic-builder/`
  - 프로젝트 밖이면 `~/.claude/dynamic-builder/`

## 배치 경로

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

1. `--scope` 값으로 `{scope-root}` 결정
2. 필요한 디렉토리 생성 (mkdir -p)
3. 산출물 디렉토리(`.local/`)에서 생성된 파일을 대상 경로에 복사
4. 배치된 파일 목록을 사용자에게 보고
5. `/dynamic-builder:build` 실행을 안내

## 주의사항

- 기존 파일을 덮어쓰기 전에 사용자에게 확인한다
- 플러그인 내부 디렉토리에는 배치하지 않는다 (사용자 소스 디렉토리에만)
