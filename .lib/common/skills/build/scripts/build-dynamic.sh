#!/usr/bin/env bash
# build-dynamic — ~/.dynamic-builder/.agent/common/scripts/에 위임
set -euo pipefail
export AGENT_HOME="__AGENT_HOME__"
export PLUGIN_DIR="__PLUGIN_DIR__"
exec bash "$HOME/.dynamic-builder/.agent/common/scripts/build-dynamic.sh" "$@"
