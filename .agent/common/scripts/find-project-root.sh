#!/usr/bin/env bash
# find-project-root — 가장 가까운 $AGENT_HOME 이름의 디렉토리를 가진 부모 디렉토리를 찾는다
# ~/$AGENT_HOME_NAME 자체는 프로젝트 루트가 아니므로 제외한다.
# 사용법: PROJECT_ROOT=$(bash find-project-root.sh)

if [ -z "$AGENT_HOME" ]; then
  echo "[ERROR] AGENT_HOME 환경변수가 설정되지 않았습니다." >&2
  exit 1
fi
AGENT_HOME_NAME="$(basename "$AGENT_HOME")"
dir="$(pwd)"
home_agent="$HOME/$AGENT_HOME_NAME"

while [ "$dir" != "/" ]; do
  if [ -d "$dir/$AGENT_HOME_NAME" ] && [ "$dir/$AGENT_HOME_NAME" != "$home_agent" ]; then
    echo "$dir"
    exit 0
  fi
  dir="$(dirname "$dir")"
done

echo ""
