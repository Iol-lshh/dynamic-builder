#!/usr/bin/env bash
# install-plugin — dynamic-builder 플러그인의 런타임 의존성을 ~/.claude에 설치한다
# skills는 플러그인이 직접 로드하므로 복사하지 않는다.
# 사용법:
#   bash .setup/scripts/install-plugin.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "=== Install Plugin Dependencies ==="
echo "Source: $REPO_DIR"
echo "Target: $CLAUDE_DIR"
echo ""

# ── scripts (빌드 산출물이 ~/.claude/에 생성되므로 필요) ──
for s in build-dynamic.sh clean-dynamic.sh clean-worktree.sh; do
  src="$REPO_DIR/scripts/$s"
  if [[ -f "$src" ]]; then
    mkdir -p "$CLAUDE_DIR/scripts"
    cp "$src" "$CLAUDE_DIR/scripts/"
    echo "[OK]   scripts/$s"
  fi
done

# ── references (agents가 런타임에 참조) ───────────────────
src_refs="$REPO_DIR/references"
dst_refs="$CLAUDE_DIR/references"
if [[ -d "$src_refs" ]]; then
  mkdir -p "$dst_refs"
  cp -r "$src_refs"/* "$dst_refs"/
  echo "[OK]   references/"
fi

# ── CLAUDE.md ───────────────────────────────────────────
src_claude_md="$REPO_DIR/CLAUDE.md"
dst_claude_md="$CLAUDE_DIR/CLAUDE.md"
if [[ ! -f "$dst_claude_md" ]]; then
  cp "$src_claude_md" "$dst_claude_md"
  echo "[OK]   CLAUDE.md (새로 생성)"
elif ! grep -qF '## Worktree 정책' "$dst_claude_md"; then
  echo "" >> "$dst_claude_md"
  cat "$src_claude_md" >> "$dst_claude_md"
  echo "[OK]   CLAUDE.md (기존 파일에 추가)"
else
  echo "[SKIP] CLAUDE.md — 이미 Worktree 정책 포함"
fi

echo ""
echo "Done."
echo ""
echo "플러그인 사용법:"
echo "  claude --plugin-dir $REPO_DIR"
