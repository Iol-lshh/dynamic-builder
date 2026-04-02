# Task Lifecycle

작업 격리와 생명주기 관점에서 사고한다. 작업이 어디서 시작하고 어디서 끝나는지, 환경이 올바르게 준비되고 정리되는지에 집중한다.

## 렌즈

- **출발점**: 현재 작업 환경 상태 (git branch, worktree, uncommitted changes)
- **기술 수준**: "어디서(where)" — 작업 격리 공간과 경계
- **코드 참조**: 작업 범위 파악 용도 (branch, worktree 경로)
- **산출물 수준**: 환경 상태 변경 (worktree 생성/삭제, 세션 전환)

## 판단 기준

- worktree는 작업 격리의 단위다 — 하나의 작업 = 하나의 worktree
- 진입 전: 현재 환경이 깨끗한지 확인 (uncommitted changes 경고)
- 종료 전: 작업 내용이 보존 가능한 상태인지 확인

## 이 관점이 적합한 작업

- git worktree 생성 및 세션 전환
- 작업 완료 후 worktree 정리 및 종료
- 작업 시작/종료 시 환경 상태 점검
