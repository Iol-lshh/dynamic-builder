#!/usr/bin/env bash
# install — dynamic-builder 통합 설치
# 사용법:
#   bash .setup/scripts/install.sh                          # 대화형 (타겟 선택 → 설치)
#   bash .setup/scripts/install.sh --target claude          # claude만
#   bash .setup/scripts/install.sh --target claude,gemini   # 복수 타겟
#   bash .setup/scripts/install.sh --target claude --force  # 확인 없이

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

# ── 타겟 선택 ─────────────────────────────────────────────
AGENT_DIR="$REPO_DIR/.agent"
AVAILABLE_TARGETS=()
for dir in "$AGENT_DIR"/*/; do
  [[ -d "$dir" ]] || continue
  name="$(basename "$dir")"
  [[ "$name" == "common" ]] && continue
  AVAILABLE_TARGETS+=("$name")
done

if [[ -z "$TARGETS" ]]; then
  echo "=== dynamic-builder 설치 ==="
  echo ""
  echo "설치 가능한 타겟:"
  for i in "${!AVAILABLE_TARGETS[@]}"; do
    echo "  $((i+1)). ${AVAILABLE_TARGETS[$i]}"
  done
  echo "  a. 전체"
  echo ""
  printf "설치할 타겟을 선택하세요 (번호/이름, 쉼표 구분): "
  read -r selection

  if [[ "$selection" == "a" || "$selection" == "전체" ]]; then
    TARGETS=$(IFS=,; echo "${AVAILABLE_TARGETS[*]}")
  else
    # 번호 또는 이름 파싱
    IFS=',' read -ra PARTS <<< "$selection"
    PARSED=()
    for part in "${PARTS[@]}"; do
      part=$(echo "$part" | xargs)  # trim
      if [[ "$part" =~ ^[0-9]+$ ]]; then
        idx=$((part - 1))
        if [[ $idx -ge 0 && $idx -lt ${#AVAILABLE_TARGETS[@]} ]]; then
          PARSED+=("${AVAILABLE_TARGETS[$idx]}")
        else
          echo "[ERROR] 잘못된 번호: $part"
          exit 1
        fi
      else
        PARSED+=("$part")
      fi
    done
    TARGETS=$(IFS=,; echo "${PARSED[*]}")
  fi
fi

# 쉼표 구분 → 배열
IFS=',' read -ra TARGET_LIST <<< "$TARGETS"

# 유효성 검증
for t in "${TARGET_LIST[@]}"; do
  if [[ ! -d "$AGENT_DIR/$t" ]]; then
    echo "[ERROR] 알 수 없는 타겟: $t"
    echo "사용 가능: ${AVAILABLE_TARGETS[*]}"
    exit 1
  fi
done

echo ""
echo "설치 타겟: ${TARGET_LIST[*]}"
echo ""

# ── .agent/ → ~/.dynamic-builder/.agent/ 복사 ────────────
mkdir -p "$DYNAMIC_BUILDER_DIR"

AGENT_SRC="$REPO_DIR/.agent"
AGENT_DST="$DYNAMIC_BUILDER_DIR/.agent"

if [[ -d "$AGENT_SRC" ]]; then
  rm -rf "$AGENT_DST"
  cp -r "$AGENT_SRC" "$AGENT_DST"
  echo "[OK]   .agent/ → $AGENT_DST 복사"
  echo ""
fi

# ── build-config 기록 ─────────────────────────────────────

# JSON 배열 생성
TARGETS_JSON="["
for i in "${!TARGET_LIST[@]}"; do
  [[ $i -gt 0 ]] && TARGETS_JSON+=","
  TARGETS_JSON+="\"${TARGET_LIST[$i]}\""
done
TARGETS_JSON+="]"

if command -v jq &>/dev/null; then
  if [[ -f "$BUILD_CONFIG" ]]; then
    # 기존 config에 targets만 업데이트
    jq --argjson targets "$TARGETS_JSON" '.targets = $targets' "$BUILD_CONFIG" > "$BUILD_CONFIG.tmp" \
      && mv "$BUILD_CONFIG.tmp" "$BUILD_CONFIG"
  else
    echo "{\"targets\": $TARGETS_JSON}" | jq '.' > "$BUILD_CONFIG"
  fi
else
  echo "{\"targets\": $TARGETS_JSON}" > "$BUILD_CONFIG"
fi
echo "[OK]   build-config 기록: $BUILD_CONFIG"
echo ""

# ── AGENT.md 복사/머지 (공통) ─────────────────────────────
SRC_AGENT="$REPO_DIR/AGENT.md"
DST_AGENT="${HOME}/.claude/AGENT.md"

if [[ -f "$SRC_AGENT" ]]; then
  if [[ ! -f "$DST_AGENT" ]]; then
    cp "$SRC_AGENT" "$DST_AGENT"
    echo "[OK]   AGENT.md (새로 생성)"
  elif ! grep -qF '# 공통 지침' "$DST_AGENT"; then
    printf '\n' >> "$DST_AGENT"
    cat "$SRC_AGENT" >> "$DST_AGENT"
    echo "[OK]   AGENT.md (머지 완료)"
  else
    echo "[SKIP] AGENT.md — 이미 포함됨"
  fi
  echo ""
fi

# ── 타겟별 설치 ───────────────────────────────────────────
for t in "${TARGET_LIST[@]}"; do
  TARGET_INSTALL="$AGENT_DST/$t/scripts/install.sh"
  if [[ -f "$TARGET_INSTALL" ]]; then
    echo "────────────────────────────────────────"
    echo "[$t] 설치 시작"
    echo "────────────────────────────────────────"
    REPO_DIR="$REPO_DIR" bash "$TARGET_INSTALL" ${PASSTHROUGH_ARGS[@]+"${PASSTHROUGH_ARGS[@]}"}
    echo ""
  else
    echo "[WARN] $t: install.sh 없음 — 스킵"
  fi
done

echo "Done. 설치 완료: ${TARGET_LIST[*]}"
