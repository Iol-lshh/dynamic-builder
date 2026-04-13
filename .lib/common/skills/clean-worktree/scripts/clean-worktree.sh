#!/usr/bin/env bash
# clean-worktree — ~/.dynamic-builder/.agent/claude/scripts/에 위임
set -euo pipefail
export AGENT_HOME="__AGENT_HOME__"
exec bash "$HOME/.dynamic-builder/.agent/claude/scripts/clean-worktree.sh" "$@"
