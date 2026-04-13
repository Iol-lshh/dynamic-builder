#!/usr/bin/env bash
# uninstall — Gemini CLI용 dynamic-builder 제거
# 사용법:
#   bash .agent/gemini/scripts/uninstall.sh
#   bash .agent/gemini/scripts/uninstall.sh --force

set -euo pipefail

GEMINI_DIR="${HOME}/.gemini"
PLUGIN_NAME="dynamic-builder"
DYNAMIC_BUILDER_DIR="${HOME}/.dynamic-builder"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Uninstall $PLUGIN_NAME (Gemini CLI) ==="
echo ""

# ── 빌드 산출물 정리 (인덱스 기반) ───────────────────────
# agent 인덱스에서 gemini 빌드물 추적
for builder in build-agent build-workflow; do
  INDEX="$DYNAMIC_BUILDER_DIR/$builder/.build-index.local.json"
  if [[ -f "$INDEX" ]] && command -v jq &>/dev/null; then
    GENERATED=$(jq -r '.gemini.generated // [] | .[]' "$INDEX" 2>/dev/null)
    if [[ -n "$GENERATED" ]]; then
      if confirm "삭제: $builder의 gemini 빌드 산출물을 정리하시겠습니까?"; then
        while IFS= read -r file; do
          if [[ "$builder" == "build-agent" ]]; then
            target="$GEMINI_DIR/agents/$file"
          else
            target="$GEMINI_DIR/skills/$file"
          fi
          if [[ -e "$target" ]]; then
            rm -rf "$target"
            echo "[OK]   삭제: $target"
          fi
        done <<< "$GENERATED"

        # 인덱스에서 gemini 항목 제거
        jq 'del(.gemini)' "$INDEX" > "$INDEX.tmp" && mv "$INDEX.tmp" "$INDEX"
        echo "[OK]   $builder 인덱스에서 gemini 항목 제거"
      else
        echo "[SKIP] $builder 빌드 산출물"
      fi
    fi
  fi
done

echo ""
echo "Done. $PLUGIN_NAME (Gemini CLI) 제거 완료."
