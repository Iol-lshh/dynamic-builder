#!/usr/bin/env bash
# uninstall — dynamic-builder를 완전히 제거한다
# 사용법:
#   bash .agent/claude/scripts/uninstall.sh              # 전체 제거 (각 단계 확인)
#   bash .agent/claude/scripts/uninstall.sh --force      # 확인 없이 전체 제거
#   bash .agent/claude/scripts/uninstall.sh --plugin     # 플러그인만
#   bash .agent/claude/scripts/uninstall.sh --settings   # hooks/settings만
#   bash .agent/claude/scripts/uninstall.sh --build      # 빌드 산출물만

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
PLUGIN_NAME="dynamic-builder"
PLUGIN_DIR="$CLAUDE_DIR/plugins/marketplaces/$PLUGIN_NAME"

# ── 옵션 파싱 ─────────────────────────────────────────────
DO_PLUGIN=false
DO_BUILD=false
DO_SETTINGS=false
FORCE=false
HAS_STEP=false

for arg in "$@"; do
  case "$arg" in
    --plugin)    DO_PLUGIN=true;   HAS_STEP=true ;;
    --build)     DO_BUILD=true;    HAS_STEP=true ;;
    --settings)  DO_SETTINGS=true; HAS_STEP=true ;;
    --force)     FORCE=true ;;
    *)
      echo "[ERROR] 알 수 없는 옵션: $arg"
      echo "사용법: uninstall.sh [--plugin] [--settings] [--build] [--force]"
      exit 1
      ;;
  esac
done

if ! $HAS_STEP; then
  DO_PLUGIN=true
  DO_SETTINGS=true
  DO_BUILD=true
fi

FORCE_FLAG=""
$FORCE && FORCE_FLAG="--force"

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Uninstall $PLUGIN_NAME ==="
echo ""

# ── 1. 빌드 산출물 삭제 ───────────────────────────────────
if $DO_BUILD; then
  CLEAN_SCRIPT="${HOME}/.dynamic-builder/.agent/common/scripts/clean-dynamic.sh"
  if [[ -f "$CLEAN_SCRIPT" ]]; then
    if confirm "실행: 빌드 산출물을 정리하시겠습니까?"; then
      echo "--- 빌드 산출물 정리 ---"
      bash "$CLEAN_SCRIPT" || echo "[WARN] clean-dynamic.sh 실행 실패 (무시하고 계속)"
    else
      echo "[SKIP] 빌드 산출물"
    fi
    echo ""
  fi
fi

# ── 2. hooks/settings 제거 ───────────────────────────────
if $DO_SETTINGS; then
  if confirm "삭제: hooks와 settings.json에서 dynamic-builder 설정을 제거하시겠습니까?"; then
    bash "$SCRIPT_DIR/uninstall-settings.sh" $FORCE_FLAG
    echo ""
  else
    echo "[SKIP] hooks/settings"
    echo ""
  fi
fi

# ── 3. 플러그인 삭제 ──────────────────────────────────────
if $DO_PLUGIN; then
  if confirm "삭제: 플러그인을 제거하시겠습니까?"; then
    bash "$SCRIPT_DIR/uninstall-plugin.sh" $FORCE_FLAG
    echo ""
  else
    echo "[SKIP] 플러그인"
    echo ""
  fi
fi

echo "Done. $PLUGIN_NAME 제거 완료."
