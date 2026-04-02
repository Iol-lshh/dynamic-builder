#!/usr/bin/env bash
# uninstall — dynamic-builder 플러그인이 ~/.claude에 설치한 모든 항목을 제거한다
# 사용법:
#   bash .setup/scripts/uninstall.sh           # 대화형 확인
#   bash .setup/scripts/uninstall.sh --force   # 확인 없이 제거

set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
FORCE=false
[[ "${1:-}" == "--force" ]] && FORCE=true

confirm() {
  if $FORCE; then return 0; fi
  printf "%s [y/N] " "$1"
  read -r ans
  [[ "$ans" =~ ^[yY] ]]
}

echo "=== Uninstall dynamic-builder ==="
echo "Target: $CLAUDE_DIR"
echo ""

# ── 1. 빌드 산출물 삭제 ───────────────────────────────────
CLEAN_SCRIPT="$CLAUDE_DIR/scripts/clean-dynamic.sh"
if [[ -f "$CLEAN_SCRIPT" ]]; then
  echo "--- 빌드 산출물 정리 ---"
  bash "$CLEAN_SCRIPT" || echo "[WARN] clean-dynamic.sh 실행 실패 (무시하고 계속)"
  echo ""
fi

# ── 2. 플러그인 설정 되돌리기 ──────────────────────────────

# hooks 제거
HOOKS=(
  protect-branch-file.sh
  protect-branch-git.sh
  protect-worktree-bash.sh
)
if confirm "삭제: hooks (protect-branch-file, protect-branch-git, protect-worktree-bash) ?"; then
  for h in "${HOOKS[@]}"; do
    target="$CLAUDE_DIR/hooks/$h"
    if [[ -f "$target" ]]; then
      rm -f "$target"
      echo "[OK]   hooks/$h 삭제"
    fi
  done
  if [[ -d "$CLAUDE_DIR/hooks" ]] && [[ -z "$(ls -A "$CLAUDE_DIR/hooks" 2>/dev/null)" ]]; then
    rmdir "$CLAUDE_DIR/hooks"
    echo "[OK]   hooks/ 디렉토리 삭제 (비어있음)"
  fi

  # settings.json에서 hook 항목 제거
  SETTINGS="$CLAUDE_DIR/settings.json"
  if [[ -f "$SETTINGS" ]] && command -v jq &>/dev/null; then
    jq 'del(.hooks)' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
    echo "[OK]   settings.json에서 hooks 항목 제거"
  fi
else
  echo "[SKIP] hooks"
fi

# CLAUDE.md 복원
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
if [[ -f "$CLAUDE_MD" ]] && grep -qF '## Worktree 정책' "$CLAUDE_MD"; then
  if confirm "삭제: CLAUDE.md에서 dynamic-builder가 추가한 내용을 제거하시겠습니까?"; then
    sed -i '' '/^# 공통 지침$/,$d' "$CLAUDE_MD"
    sed -i '' -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$CLAUDE_MD"
    if [[ ! -s "$CLAUDE_MD" ]]; then
      rm -f "$CLAUDE_MD"
      echo "[OK]   CLAUDE.md 삭제 (내용이 비어 전체 삭제)"
    else
      echo "[OK]   CLAUDE.md에서 dynamic-builder 블록 제거"
    fi
  else
    echo "[SKIP] CLAUDE.md"
  fi
fi

# permissions에서 스크립트 허용 항목 제거
SETTINGS="$CLAUDE_DIR/settings.json"
if [[ -f "$SETTINGS" ]] && command -v jq &>/dev/null; then
  jq '.permissions.allow = [.permissions.allow[] | select(startswith("Bash(bash .claude/scripts/") | not)]' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
  echo "[OK]   settings.json에서 스크립트 허용 항목 제거"
fi

# ── 3. 플러그인 의존성 삭제 ───────────────────────────────

# scripts 제거
SCRIPTS=(
  build-dynamic.sh
  clean-dynamic.sh
  clean-worktree.sh
)
for s in "${SCRIPTS[@]}"; do
  target="$CLAUDE_DIR/scripts/$s"
  if [[ -f "$target" ]]; then
    rm -f "$target"
    echo "[OK]   scripts/$s 삭제"
  fi
done
if [[ -d "$CLAUDE_DIR/scripts" ]] && [[ -z "$(ls -A "$CLAUDE_DIR/scripts" 2>/dev/null)" ]]; then
  rmdir "$CLAUDE_DIR/scripts"
  echo "[OK]   scripts/ 디렉토리 삭제 (비어있음)"
fi

# references 제거
REFS=(
  Wikipedia_Signs_of_AI_writing_EN.md
  Wikipedia_Signs_of_AI_writing_KR.md
  condition-coverage-guide.md
  context-isolation-principle.md
  figma-access.md
  test-rules.md
  usecase-guide.md
)
for r in "${REFS[@]}"; do
  target="$CLAUDE_DIR/references/$r"
  if [[ -f "$target" ]]; then
    rm -f "$target"
    echo "[OK]   references/$r 삭제"
  fi
done
if [[ -d "$CLAUDE_DIR/references" ]] && [[ -z "$(ls -A "$CLAUDE_DIR/references" 2>/dev/null)" ]]; then
  rmdir "$CLAUDE_DIR/references"
  echo "[OK]   references/ 디렉토리 삭제 (비어있음)"
fi

echo ""
echo "Done. dynamic-builder 제거 완료."
