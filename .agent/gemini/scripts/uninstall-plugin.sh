#!/usr/bin/env bash
# uninstall-plugin — dynamic-builder 플러그인 디렉토리를 제거하고 settings.json에서 등록을 해제한다
# 사용법:
#   bash .agent/gemini/scripts/uninstall-plugin.sh           # 대화형 확인
#   bash .agent/gemini/scripts/uninstall-plugin.sh --force   # 확인 없이 제거

set -euo pipefail

GEMINI_DIR="${HOME}/.gemini"
PLUGIN_NAME="dynamic-builder"
PLUGIN_DIR="$GEMINI_DIR/extensions/marketplaces/$PLUGIN_NAME"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Uninstall Extension ($PLUGIN_NAME) ==="
echo ""

# ── 확장 디렉토리 삭제 ──────────────────────────────────
if [[ -d "$PLUGIN_DIR" ]]; then
  if confirm "삭제: $PLUGIN_DIR ?"; then
    rm -rf "$PLUGIN_DIR"
    echo "[OK]   확장 디렉토리 삭제"
  else
    echo "[SKIP] 확장 디렉토리"
  fi
else
  echo "[SKIP] 확장 디렉토리 없음"
fi

# ── settings.json에서 마켓플레이스 & 확장 등록 제거 ────
SETTINGS="$GEMINI_DIR/settings.json"
if [[ -f "$SETTINGS" ]] && command -v jq &>/dev/null; then
  jq --arg name "$PLUGIN_NAME" '
    del(.extraKnownMarketplaces[$name])
    | del(.enabledExtensions[($name + "@" + $name)])
  ' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에서 마켓플레이스 & 확장 등록 제거"
fi

echo ""
echo "Done."
