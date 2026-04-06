#!/usr/bin/env bash
# build-dynamic — agent와 workflow를 빌드한다
# 사용법:
#   ./build-dynamic.sh            # 전체 빌드 (agent → workflow)
#   ./build-dynamic.sh --agent    # agent만
#   ./build-dynamic.sh --workflow # workflow만

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

AGENT_SCRIPT="$PLUGIN_DIR/skills/dynamic-agent-builder/scripts/build-agents.js"
WORKFLOW_SCRIPT="$PLUGIN_DIR/skills/dynamic-workflow-builder/scripts/build-workflow.js"

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
