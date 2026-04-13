# Worktree Entry

새 작업을 시작하기 위해 worktree를 생성하고 세션을 전환한다.

## 실행 절차

1. `git branch --show-current && git status --short`로 현재 상태 확인
2. uncommitted changes가 있으면 사용자에게 경고하고 계속 진행 여부 확인
3. 전달받은 작업명으로 `EnterWorktree` 도구 호출
4. 전환된 worktree 경로와 브랜치명 보고
