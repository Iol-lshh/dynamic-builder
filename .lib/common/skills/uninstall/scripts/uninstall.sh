#!/usr/bin/env bash
# uninstall — ~/.dynamic-builder/.agent/claude/scripts/에 위임
set -euo pipefail
export AGENT_HOME="__AGENT_HOME__"
exec bash "$HOME/.dynamic-builder/.agent/claude/scripts/uninstall.sh" "$@"
