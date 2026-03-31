# 공통 지침

## Worktree 정책

- **worktree를 자동으로 생성하지 마라.** 사용자가 명시적으로 요청하거나 `/worktree-entry-workflow`를 실행할 때만 생성한다.
- 보호 브랜치에서 파일 수정이 차단되면, worktree를 바로 만들지 말고 사용자에게 worktree 생성 여부를 먼저 확인한다.
- 읽기 전용 작업(질문 답변, 코드 분석, 검색 등)은 worktree 없이 수행한다.
- **worktree 세션에서 파일을 수정할 때는 반드시 worktree 경로를 사용한다.** `@file`로 원본 경로가 참조되어도 Edit/Write는 worktree 경로(`.../.claude/worktrees/{name}/...`)로 변환하여 적용한다. 원본 리포지토리를 직접 수정하면 worktree를 만든 의미가 없다.

## 컨텍스트 격리 원칙

**필수 참조: `~/.claude/references/context-isolation-principle.md`**
