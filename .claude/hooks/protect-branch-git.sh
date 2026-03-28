#!/usr/bin/env bash
# Bash 도구의 git commit/push/merge/rebase/reset 전에 보호 브랜치 여부를 확인한다

INPUT=$(cat)
BRANCH=$(git branch --show-current 2>/dev/null)
GIT_CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

if [[ "$BRANCH" =~ ^(main|master|dev|stag|rc) ]] && echo "$GIT_CMD" | grep -qE 'git (commit|push|merge|rebase|reset)'; then
  echo "{\"decision\":\"block\",\"reason\":\"보호 브랜치 [$BRANCH] 에서 직접 작업은 금지입니다. /worktree-entry-workflow 로 worktree를 생성하세요.\"}"
  exit 2
fi
