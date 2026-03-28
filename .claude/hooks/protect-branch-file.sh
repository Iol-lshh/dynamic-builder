#!/usr/bin/env bash
# Edit, Write, MultiEdit 전에 보호 브랜치 여부를 확인한다

BRANCH=$(git branch --show-current 2>/dev/null)

if [[ "$BRANCH" =~ ^(main|master|dev|stag|rc) ]]; then
  echo "{\"decision\":\"block\",\"reason\":\"보호 브랜치 [$BRANCH] 에서 직접 작업은 금지입니다. /worktree-entry-workflow 로 worktree를 생성하세요.\"}"
  exit 2
fi
