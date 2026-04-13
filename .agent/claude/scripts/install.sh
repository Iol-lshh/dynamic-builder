#!/usr/bin/env bash
# install — dynamic-builder 플러그인 설치
# 사용법:
#   bash .agent/claude/scripts/install.sh            # 전체 설치 (각 단계 확인)
#   bash .agent/claude/scripts/install.sh --force    # 확인 없이 전체 설치
#   bash .agent/claude/scripts/install.sh --plugin   # 플러그인만
#   bash .agent/claude/scripts/install.sh --settings # hooks/settings만
#   bash .agent/claude/scripts/install.sh --build    # 빌드만

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DYNAMIC_BUILDER_DIR="${HOME}/.dynamic-builder"
PLUGIN_DIR="$HOME/.claude/plugins/marketplaces/dynamic-builder"

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
      echo "사용법: install.sh [--plugin] [--settings] [--build] [--force]"
      exit 1
      ;;
  esac
done

# 개별 단계 지정이 없으면 전부 실행
if ! $HAS_STEP; then
  DO_PLUGIN=true
  DO_SETTINGS=true
  DO_BUILD=true
fi

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Install dynamic-builder ==="
echo ""

# ── 1. 플러그인 설치 ─────────────────────────────────────
if $DO_PLUGIN; then
  if confirm "설치: 플러그인을 ~/.claude/plugins/marketplaces/에 복사하시겠습니까?"; then
    bash "$SCRIPT_DIR/install-plugin.sh"
    echo ""
  else
    echo "[SKIP] 플러그인 설치"
    echo ""
  fi
fi

# ── 2. hooks/settings 설치 ───────────────────────────────
if $DO_SETTINGS; then
  if confirm "설치: hooks와 settings.json을 ~/.claude/에 설치하시겠습니까?"; then
    bash "$SCRIPT_DIR/install-settings.sh"
    echo ""
  else
    echo "[SKIP] hooks/settings"
    echo ""
  fi
fi

# ── 3. 빌드 ─────────────────────────────────────────────
if $DO_BUILD; then
  AGENT_SCRIPT="$PLUGIN_DIR/skills/build-agent/scripts/build-agents.js"
  WORKFLOW_SCRIPT="$PLUGIN_DIR/skills/build-workflow/scripts/build-workflow.js"

  if confirm "실행: agent 빌드를 실행하시겠습니까?"; then
    if [[ -f "$AGENT_SCRIPT" ]]; then
      echo "=== Agent Build ==="
      node "$AGENT_SCRIPT"
    else
      echo "[ERROR] build-agents.js를 찾을 수 없습니다: $AGENT_SCRIPT"
      echo "        플러그인이 먼저 설치되어야 합니다."
    fi
    echo ""

    if confirm "실행: workflow 빌드를 실행하시겠습니까?"; then
      if [[ -f "$WORKFLOW_SCRIPT" ]]; then
        echo "=== Workflow Build ==="
        node "$WORKFLOW_SCRIPT"
      else
        echo "[ERROR] build-workflow.js를 찾을 수 없습니다: $WORKFLOW_SCRIPT"
        echo "        플러그인이 먼저 설치되어야 합니다."
      fi
      echo ""
    else
      echo "[SKIP] workflow 빌드"
      echo ""
    fi
  else
    echo "[SKIP] 빌드"
    echo ""
  fi
fi

echo "Done."
