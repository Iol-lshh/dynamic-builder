#!/usr/bin/env bash
# Bash 도구의 git 명령 실행 전 보호 규칙:
# 1) push|merge|rebase|reset → 무조건 금지
# 2) main|master|dev|stag|rc prefix 브랜치 → commit도 금지

INPUT=$(cat)
BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
GIT_CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# 1) push|merge|rebase|reset → 무조건 금지
if echo "$GIT_CMD" | grep -qE 'git (push|merge|rebase|reset)'; then
  echo "{\"decision\":\"block\",\"reason\":\"git push/merge/rebase/reset 는 금지된 명령입니다. 사용자가 직접 터미널에서 수행하세요.\"}"
  exit 2
fi

# 2) 보호 브랜치(main|master|dev|stag|rc prefix)에서 commit 금지
if echo "$GIT_CMD" | grep -qE 'git commit'; then
  if [[ "$BRANCH" =~ ^(main|master|dev|stag|rc) ]]; then
    echo "{\"decision\":\"block\",\"reason\":\"보호 브랜치($BRANCH)에서는 commit이 금지됩니다. 별도 브랜치에서 작업하세요.\"}"
    exit 2
  fi
fi
