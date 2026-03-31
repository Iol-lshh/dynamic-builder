#!/usr/bin/env bash
# clean-dynamic — 빌드된 agent와 workflow 산출물을 삭제한다
# 사용법:
#   ./clean-dynamic.sh            # 전체 삭제
#   ./clean-dynamic.sh --agent    # agent만
#   ./clean-dynamic.sh --workflow # workflow만

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"

AGENT_SCRIPT="$CLAUDE_DIR/skills/dynamic-agent-builder/scripts/build-agents.js"
WORKFLOW_SCRIPT="$CLAUDE_DIR/skills/dynamic-workflow-builder/scripts/build-workflow.js"

clean_agent=false
clean_workflow=false

if [[ $# -eq 0 ]]; then
  clean_agent=true
  clean_workflow=true
fi

for arg in "$@"; do
  case "$arg" in
    --agent)    clean_agent=true ;;
    --workflow) clean_workflow=true ;;
    *)          echo "Unknown option: $arg"; exit 1 ;;
  esac
done

if $clean_agent; then
  echo "=== Agent Clean ==="
  node "$AGENT_SCRIPT" --clean
fi

if $clean_workflow; then
  echo "=== Workflow Clean ==="
  node "$WORKFLOW_SCRIPT" --clean
fi
