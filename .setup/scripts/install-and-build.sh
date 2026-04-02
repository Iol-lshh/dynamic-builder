#!/usr/bin/env bash
# install-and-build — 플러그인 의존성 설치 후 agent + workflow 빌드까지 실행한다
# 사용법:
#   bash .setup/scripts/install-and-build.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── 1. 플러그인 의존성 설치 ────────────────────────────────
bash "$SCRIPT_DIR/install-plugin.sh"

echo ""

# ── 2. 빌드 ─────────────────────────────────────────────
BUILD_SCRIPT="$HOME/.claude/scripts/build-dynamic.sh"
if [[ -f "$BUILD_SCRIPT" ]]; then
  bash "$BUILD_SCRIPT"
else
  echo "[ERROR] build-dynamic.sh를 찾을 수 없습니다: $BUILD_SCRIPT"
  echo "        install-plugin.sh가 먼저 실행되었는지 확인하세요."
  exit 1
fi
