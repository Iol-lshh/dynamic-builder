#!/usr/bin/env bash
# uninstall — dynamic-builder 통합 제거
# 사용법:
#   bash .setup/scripts/uninstall.sh              # 대화형 확인 후 제거
#   bash .setup/scripts/uninstall.sh --force      # 확인 없이 제거
#   bash .setup/scripts/uninstall.sh --target claude  # 특정 타겟만

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DYNAMIC_BUILDER_DIR="${HOME}/.dynamic-builder"
BUILD_CONFIG="$DYNAMIC_BUILDER_DIR/.build-config.local.json"

# ── 옵션 파싱 ─────────────────────────────────────────────
TARGETS=""
FORCE=false
PASSTHROUGH_ARGS=()

for arg in "$@"; do
  case "$arg" in
    --target)  shift_next=true ;;
    --target=*) TARGETS="${arg#--target=}" ;;
    --force)   FORCE=true; PASSTHROUGH_ARGS+=("--force") ;;
    *)
      if [[ "${shift_next:-}" == "true" ]]; then
        TARGETS="$arg"
        shift_next=false
      else
        PASSTHROUGH_ARGS+=("$arg")
      fi
      ;;
  esac
done

# ── 타겟 결정 ─────────────────────────────────────────────
if [[ -z "$TARGETS" ]]; then
  # build-config에서 설치된 타겟 읽기
  if [[ -f "$BUILD_CONFIG" ]] && command -v jq &>/dev/null; then
    TARGETS=$(jq -r '.targets // [] | join(",")' "$BUILD_CONFIG")
  fi
fi

if [[ -z "$TARGETS" ]]; then
  echo "[ERROR] 설치된 타겟 정보를 찾을 수 없습니다."
  echo "        --target 옵션으로 지정하거나, 먼저 install을 실행하세요."
  exit 1
fi

IFS=',' read -ra TARGET_LIST <<< "$TARGETS"

echo "=== dynamic-builder 제거 ==="
echo "대상 타겟: ${TARGET_LIST[*]}"
echo ""

# ── 타겟별 제거 ───────────────────────────────────────────
for t in "${TARGET_LIST[@]}"; do
  TARGET_UNINSTALL="$DYNAMIC_BUILDER_DIR/.agent/$t/scripts/uninstall.sh"
  if [[ -f "$TARGET_UNINSTALL" ]]; then
    echo "────────────────────────────────────────"
    echo "[$t] 제거 시작"
    echo "────────────────────────────────────────"
    REPO_DIR="$REPO_DIR" bash "$TARGET_UNINSTALL" ${PASSTHROUGH_ARGS[@]+"${PASSTHROUGH_ARGS[@]}"}
    echo ""
  else
    echo "[WARN] $t: uninstall.sh 없음 — 스킵"
  fi
done

# ── AGENT.md 블록 제거 (공통) ─────────────────────────────
AGENT_MD="${HOME}/.claude/AGENT.md"
if [[ -f "$AGENT_MD" ]] && grep -qF '# 공통 지침' "$AGENT_MD"; then
  sed -i '' '/^# 공통 지침$/,$d' "$AGENT_MD"
  sed -i '' -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$AGENT_MD"
  if [[ ! -s "$AGENT_MD" ]]; then
    rm -f "$AGENT_MD"
    echo "[OK]   AGENT.md 삭제 (내용이 비어 전체 삭제)"
  else
    echo "[OK]   AGENT.md에서 dynamic-builder 블록 제거"
  fi
fi

# ── .agent/ 정리 ─────────────────────────────────────────
AGENT_DST="$DYNAMIC_BUILDER_DIR/.agent"
if [[ -d "$AGENT_DST" ]]; then
  rm -rf "$AGENT_DST"
  echo "[OK]   $AGENT_DST 삭제"
fi

# ── build-config 정리 ────────────────────────────────────
if [[ -f "$BUILD_CONFIG" ]]; then
  rm -f "$BUILD_CONFIG"
  echo "[OK]   build-config 삭제: $BUILD_CONFIG"
fi

echo ""
echo "Done. 제거 완료: ${TARGET_LIST[*]}"
