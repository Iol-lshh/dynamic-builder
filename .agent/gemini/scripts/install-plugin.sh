#!/usr/bin/env bash
# install-plugin — dynamic-builder 플러그인을 ~/.gemini/plugins/marketplaces/에 설치한다
# 사용법:
#   bash .agent/gemini/scripts/install-plugin.sh

set -euo pipefail

REPO_DIR="${REPO_DIR:-$(cd "$(dirname "$0")/../../.." && pwd)}"
PLUGIN_NAME="dynamic-builder"
MARKETPLACE_DIR="${HOME}/.gemini/extensions"
PLUGIN_DIR="$MARKETPLACE_DIR/$PLUGIN_NAME"
LIB_DIR="$REPO_DIR/.lib"

echo "=== Install Extension: $PLUGIN_NAME ==="
echo "Source: $LIB_DIR"
echo "Target: $PLUGIN_DIR"
echo ""

# ── .lib/claude + .lib/common → 확장 디렉토리로 복사 ─────
mkdir -p "$MARKETPLACE_DIR"

if [[ -d "$PLUGIN_DIR" ]]; then
  echo "[INFO] 기존 설치 발견 — 덮어씁니다."
  rm -rf "$PLUGIN_DIR"
fi

mkdir -p "$PLUGIN_DIR"

# 공통 먼저
if [[ -d "$LIB_DIR/common" ]]; then
  cp -r "$LIB_DIR/common"/. "$PLUGIN_DIR"/
  echo "[OK]   .lib/common/"
fi

# claude 전용 (오버라이드)
if [[ -d "$LIB_DIR/claude" ]]; then
  cp -r "$LIB_DIR/claude"/. "$PLUGIN_DIR"/
  echo "[OK]   .lib/claude/"
fi

# 플레이스홀더 치환
AGENT_HOME="$HOME/.gemini"
AGENT_HOME_NAME=".gemini"
find "$PLUGIN_DIR" \( -name "*.sh" -o -name "*.js" -o -name "*.md" -o -name "*.yaml" \) | while read -r f; do
  if grep -q '__AGENT_HOME\|__PLUGIN_DIR__' "$f" 2>/dev/null; then
    sed -i '' "s|__AGENT_HOME_NAME__|$AGENT_HOME_NAME|g; s|__AGENT_HOME__|$AGENT_HOME|g; s|__PLUGIN_DIR__|$PLUGIN_DIR|g" "$f"
  fi
done
echo "[OK]   AGENT_HOME=$AGENT_HOME, PLUGIN_DIR=$PLUGIN_DIR 주입"

echo "[OK]   확장 복사 완료"

# ── settings.json에 마켓플레이스 & 확장 등록 ──────────────
SETTINGS="${HOME}/.gemini/settings.json"
if command -v jq &>/dev/null && [[ -f "$SETTINGS" ]]; then
  jq --arg name "$PLUGIN_NAME" --arg path "$PLUGIN_DIR" '
    .extraKnownMarketplaces[$name] = {
      "source": { "source": "directory", "path": $path }
    }
    | .enabledExtensions[($name + "@" + $name)] = true
  ' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에 마켓플레이스 & 확장 등록"
else
  echo "[WARN] jq가 없거나 settings.json이 없어 수동 등록이 필요합니다."
fi

echo ""
echo "Done. 확장이 설치되었습니다."
echo "  $PLUGIN_DIR"
