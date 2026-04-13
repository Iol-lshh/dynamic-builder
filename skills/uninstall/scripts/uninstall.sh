#!/usr/bin/env bash
# uninstall — .setup/claude/scripts/uninstall.sh에 위임
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")"
SETUP_UNINSTALL="$PLUGIN_ROOT/.setup/claude/scripts/uninstall.sh"

bash "$SETUP_UNINSTALL" "$@"
