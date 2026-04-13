#!/usr/bin/env bash
# find-project-root — ~/.dynamic-builder/.agent/common/scripts/에 위임
set -euo pipefail
export AGENT_HOME="__AGENT_HOME__"
exec bash "$HOME/.dynamic-builder/.agent/common/scripts/find-project-root.sh" "$@"
