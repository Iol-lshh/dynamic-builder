#!/usr/bin/env bash
# Edit, Write, MultiEdit 전에 보호 규칙:
# 1) 보호 브랜치(main|master|dev|stag|rc prefix) → 수정 금지
# 2) 워크트리 바깥 → 수정 금지

BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
GIT_DIR=$(git rev-parse --git-dir 2>/dev/null)

# 1) 보호 브랜치에서 수정 금지
if [[ "$BRANCH" =~ ^(main|master|dev|stag|rc) ]]; then
  echo "{\"decision\":\"block\",\"reason\":\"보호 브랜치 [$BRANCH] 에서 직접 작업은 금지입니다. /worktree-entry-workflow 로 worktree를 생성하세요.\"}"
  exit 2
fi

# 2) 워크트리 바깥에서 수정 금지
if [[ "$GIT_DIR" != *"/worktrees/"* ]]; then
  echo "{\"decision\":\"block\",\"reason\":\"워크트리 바깥(브랜치: $BRANCH)에서 파일 수정은 금지됩니다. /worktree-entry-workflow 로 worktree를 생성하세요.\"}"
  exit 2
fi
