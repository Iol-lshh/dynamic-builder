#!/usr/bin/env bash
# uninstall-settings — hooks와 settings.json에서 dynamic-builder 설정을 제거한다
# 사용법:
#   bash .setup/scripts/uninstall-settings.sh           # 대화형 확인
#   bash .setup/scripts/uninstall-settings.sh --force   # 확인 없이 제거

set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
PLUGIN_NAME="dynamic-builder"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Uninstall Settings ($PLUGIN_NAME) ==="
echo ""

# ── hooks 제거 ────────────────────────────────────────────
SRC_HOOKS="$(cd "$(dirname "$0")/../.." && pwd)/.setup/hooks"
if [[ -d "$SRC_HOOKS" ]]; then
  for src in "$SRC_HOOKS"/*; do
    h="$(basename "$src")"
    target="$CLAUDE_DIR/hooks/$h"
    if [[ -f "$target" ]]; then
      rm -f "$target"
      echo "[OK]   hooks/$h 삭제"
    fi
  done
fi
if [[ -d "$CLAUDE_DIR/hooks" ]] && [[ -z "$(ls -A "$CLAUDE_DIR/hooks" 2>/dev/null)" ]]; then
  rmdir "$CLAUDE_DIR/hooks"
  echo "[OK]   hooks/ 디렉토리 삭제 (비어있음)"
fi

# ── settings.json에서 hook 항목 제거 ──────────────────────
SETTINGS="$CLAUDE_DIR/settings.json"
if [[ -f "$SETTINGS" ]] && command -v jq &>/dev/null; then
  jq 'del(.hooks)' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에서 hooks 항목 제거"
fi

# ── permissions에서 스크립트 허용 항목 제거 ────────────────
if [[ -f "$SETTINGS" ]] && command -v jq &>/dev/null; then
  jq --arg prefix "Bash(bash ~/.claude/plugins/marketplaces/dynamic-builder/skills/" '.permissions.allow = [.permissions.allow[] | select(startswith($prefix) | not)]' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에서 스크립트 허용 항목 제거"
fi

echo ""
echo "Done."
