#!/usr/bin/env bash
# find-project-root — 가장 가까운 .claude/ 디렉토리를 가진 부모 디렉토리를 찾는다
# ~/.claude 자체는 프로젝트 루트가 아니므로 제외한다.
# 사용법: PROJECT_ROOT=$(bash find-project-root.sh)

dir="$(pwd)"
home_claude="$HOME/.claude"

while [ "$dir" != "/" ]; do
  if [ -d "$dir/.claude" ] && [ "$dir/.claude" != "$home_claude" ]; then
    echo "$dir"
    exit 0
  fi
  dir="$(dirname "$dir")"
done

echo ""
