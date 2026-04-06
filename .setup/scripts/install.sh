#!/usr/bin/env bash
# install — dynamic-builder 플러그인 설치
# 사용법:
#   bash .setup/scripts/install.sh                    # 플러그인만 (기본)
#   bash .setup/scripts/install.sh --build            # 플러그인 + 빌드
#   bash .setup/scripts/install.sh --settings         # 플러그인 + hooks/settings
#   bash .setup/scripts/install.sh --build --settings # 플러그인 + 빌드 + settings
#   bash .setup/scripts/install.sh --all              # 전부
#   bash .setup/scripts/install.sh --force            # 확인 없이 실행

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$HOME/.claude/plugins/marketplaces/dynamic-builder"

# ── 옵션 파싱 ─────────────────────────────────────────────
DO_BUILD=false
DO_SETTINGS=false
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --all)       DO_BUILD=true; DO_SETTINGS=true ;;
    --build)     DO_BUILD=true ;;
    --settings)  DO_SETTINGS=true ;;
    --force)     FORCE=true ;;
    *)
      echo "[ERROR] 알 수 없는 옵션: $arg"
      echo "사용법: install.sh [--build] [--settings] [--all] [--force]"
      exit 1
      ;;
  esac
done

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Install dynamic-builder ==="
echo ""

# ── 1. 플러그인 설치 (항상) ───────────────────────────────
if confirm "설치: 플러그인을 ~/.claude/plugins/marketplaces/에 복사하시겠습니까?"; then
  bash "$SCRIPT_DIR/install-plugin.sh"
  echo ""
else
  echo "[SKIP] 플러그인 설치"
  echo ""
fi

# ── 2. 빌드 ─────────────────────────────────────────────
if $DO_BUILD; then
  AGENT_SCRIPT="$PLUGIN_DIR/skills/dynamic-agent-builder/scripts/build-agents.js"
  WORKFLOW_SCRIPT="$PLUGIN_DIR/skills/dynamic-workflow-builder/scripts/build-workflow.js"

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

# ── 3. hooks/settings 설치 ───────────────────────────────
if $DO_SETTINGS; then
  if confirm "설치: hooks와 settings.json을 ~/.claude/에 설치하시겠습니까?"; then
    bash "$SCRIPT_DIR/install-settings.sh"
    echo ""
  else
    echo "[SKIP] hooks/settings"
    echo ""
  fi
fi

echo "Done."
