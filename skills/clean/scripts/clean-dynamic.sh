#!/usr/bin/env bash
# clean-dynamic — 빌드된 agent와 workflow 산출물을 삭제한다
# 사용법:
#   ./clean-dynamic.sh            # 전체 삭제
#   ./clean-dynamic.sh --agent    # agent만
#   ./clean-dynamic.sh --workflow # workflow만

set -euo pipefail

# homebrew node PATH 보정 (Claude Code 셸 환경에서 누락될 수 있음)
for p in /opt/homebrew/bin /usr/local/bin; do
  [[ -d "$p" ]] && [[ ":$PATH:" != *":$p:"* ]] && export PATH="$p:$PATH"
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")"

AGENT_SCRIPT="$PLUGIN_DIR/skills/build-agent/scripts/build-agents.js"
WORKFLOW_SCRIPT="$PLUGIN_DIR/skills/build-workflow/scripts/build-workflow.js"

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
