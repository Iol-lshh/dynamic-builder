#!/usr/bin/env bash
# install-plugin — dynamic-builder 플러그인을 ~/.claude/plugins/marketplaces/에 설치한다
# 사용법:
#   bash .setup/scripts/install-plugin.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_NAME="dynamic-builder"
MARKETPLACE_DIR="${HOME}/.claude/plugins/marketplaces"
PLUGIN_DIR="$MARKETPLACE_DIR/$PLUGIN_NAME"

echo "=== Install Plugin: $PLUGIN_NAME ==="
echo "Source: $REPO_DIR"
echo "Target: $PLUGIN_DIR"
echo ""

# ── 플러그인 디렉토리 통째로 복사 ─────────────────────────────
mkdir -p "$MARKETPLACE_DIR"

if [[ -d "$PLUGIN_DIR" ]]; then
  echo "[INFO] 기존 설치 발견 — 덮어씁니다."
  rm -rf "$PLUGIN_DIR"
fi

cp -r "$REPO_DIR" "$PLUGIN_DIR"
echo "[OK]   플러그인 복사 완료"

# ── settings.json에 마켓플레이스 & 플러그인 등록 ──────────────
SETTINGS="${HOME}/.claude/settings.json"
if command -v jq &>/dev/null && [[ -f "$SETTINGS" ]]; then
  jq --arg name "$PLUGIN_NAME" --arg path "$PLUGIN_DIR" '
    .extraKnownMarketplaces[$name] = {
      "source": { "source": "directory", "path": $path }
    }
    | .enabledPlugins[($name + "@" + $name)] = true
  ' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에 마켓플레이스 & 플러그인 등록"
else
  echo "[WARN] jq가 없거나 settings.json이 없어 수동 등록이 필요합니다."
fi

echo ""
echo "Done. 플러그인이 설치되었습니다."
echo "  $PLUGIN_DIR"
