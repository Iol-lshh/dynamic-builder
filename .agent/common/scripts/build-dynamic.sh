#!/usr/bin/env bash
# build-dynamic — agent와 workflow를 빌드한다
# 사용법:
#   ./build-dynamic.sh            # 전체 빌드 (agent → workflow)
#   ./build-dynamic.sh --agent    # agent만
#   ./build-dynamic.sh --workflow # workflow만

set -euo pipefail

# homebrew node PATH 보정 (Claude Code 셸 환경에서 누락될 수 있음)
for p in /opt/homebrew/bin /usr/local/bin; do
  [[ -d "$p" ]] && [[ ":$PATH:" != *":$p:"* ]] && export PATH="$p:$PATH"
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

AGENT_SCRIPT="$SCRIPT_DIR/build-agents.js"
WORKFLOW_SCRIPT="$SCRIPT_DIR/build-workflow.js"

build_agent=false
build_workflow=false

if [[ $# -eq 0 ]]; then
  build_agent=true
  build_workflow=true
fi

for arg in "$@"; do
  case "$arg" in
    --agent)    build_agent=true ;;
    --workflow) build_workflow=true ;;
    *)          echo "Unknown option: $arg"; exit 1 ;;
  esac
done

if $build_agent; then
  echo "=== Agent Build ==="
  node "$AGENT_SCRIPT"
fi

if $build_workflow; then
  echo "=== Workflow Build ==="
  node "$WORKFLOW_SCRIPT"
fi
