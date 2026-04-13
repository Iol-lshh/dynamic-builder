#!/usr/bin/env bash
# clean-dynamic — ~/.dynamic-builder/.agent/common/scripts/에 위임
set -euo pipefail
export AGENT_HOME="__AGENT_HOME__"
exec bash "$HOME/.dynamic-builder/.agent/common/scripts/clean-dynamic.sh" "$@"
