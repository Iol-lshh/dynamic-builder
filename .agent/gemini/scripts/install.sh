#!/usr/bin/env bash
# install — Gemini CLI용 dynamic-builder 설치
# 사용법:
#   bash .agent/gemini/scripts/install.sh
#   bash .agent/gemini/scripts/install.sh --force

set -euo pipefail

GEMINI_DIR="${HOME}/.gemini"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Install dynamic-builder (Gemini CLI) ==="
echo ""

# ── 디렉토리 생성 ────────────────────────────────────────
if confirm "설치: Gemini CLI 디렉토리를 생성하시겠습니까?"; then
  mkdir -p "$GEMINI_DIR/agents"
  mkdir -p "$GEMINI_DIR/skills"
  echo "[OK]   ~/.gemini/agents/ 생성"
  echo "[OK]   ~/.gemini/skills/ 생성"
else
  echo "[SKIP] 디렉토리 생성"
fi

echo ""
echo "Done. Gemini CLI 설치 완료."
echo "  빌드 실행 후 ~/.gemini/agents/와 ~/.gemini/skills/에 결과가 생성됩니다."
