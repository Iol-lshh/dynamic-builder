#!/usr/bin/env bash
# Bash 명령의 워크트리 밖 접근을 차단한다
# git 명령은 protect-branch-git.sh에서 별도 처리

INPUT=$(cat)
GIT_DIR=$(git rev-parse --git-dir 2>/dev/null)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# git 명령은 별도 hook에서 처리
if echo "$CMD" | grep -qE '^\s*git\s'; then
  exit 0
fi

# 1) 워크트리 바깥이면 차단
if [[ "$GIT_DIR" != *"/worktrees/"* ]]; then
  BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
  echo "{\"decision\":\"block\",\"reason\":\"워크트리 바깥(브랜치: $BRANCH)에서 Bash 명령은 금지됩니다. /worktree-entry-workflow 로 worktree를 생성하세요.\"}"
  exit 2
fi

# 2) 워크트리 안: 밖으로 탈출하는 경로 차단
WORKTREE_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

# 명령에서 절대경로 추출 후 워크트리 밖이면 차단 (안전한 경로 제외)
SAFE_PATTERN="^/(dev/null|tmp|var/folders|usr/bin|usr/local|bin|opt|etc)"
ABS_PATHS=$(echo "$CMD" | grep -oE '/[A-Za-z][A-Za-z0-9._/ -]*' | grep -vE "$SAFE_PATTERN" || true)
for p in $ABS_PATHS; do
  RESOLVED=$(realpath -m "$p" 2>/dev/null || echo "$p")
  if [[ "$RESOLVED" != "$WORKTREE_ROOT"* ]]; then
    echo "{\"decision\":\"block\",\"reason\":\"워크트리 밖 경로($RESOLVED)에 접근하는 명령은 금지됩니다.\"}"
    exit 2
  fi
done

# ../로 워크트리 루트 위로 탈출하는지 확인
if echo "$CMD" | grep -qE '\.\./' ; then
  CWD=$(pwd)
  # ../ 패턴을 포함한 상대경로를 해석
  REL_PATHS=$(echo "$CMD" | grep -oE '[.a-zA-Z0-9_/-]*\.\./[.a-zA-Z0-9_/-]*' || true)
  for rp in $REL_PATHS; do
    RESOLVED=$(realpath -m "$CWD/$rp" 2>/dev/null || echo "")
    if [ -n "$RESOLVED" ] && [[ "$RESOLVED" != "$WORKTREE_ROOT"* ]]; then
      echo "{\"decision\":\"block\",\"reason\":\"워크트리 밖으로 탈출하는 경로($rp → $RESOLVED)는 금지됩니다.\"}"
      exit 2
    fi
  done
fi

exit 0
