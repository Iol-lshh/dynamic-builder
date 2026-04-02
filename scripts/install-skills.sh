#!/usr/bin/env bash
# install-skills — dynamic-agent-builder, dynamic-workflow-builder, references, CLAUDE.md를 ~/.claude에 설치한다
# 사용법:
#   bash scripts/install-skills.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "=== Install Skills ==="
echo "Source: $REPO_DIR"
echo "Target: $CLAUDE_DIR"
echo ""

# ── skills ──────────────────────────────────────────────
for skill in dynamic-agent-builder dynamic-workflow-builder; do
  src="$REPO_DIR/skills/$skill"
  dst="$CLAUDE_DIR/skills/$skill"
  if [[ ! -d "$src" ]]; then
    echo "[SKIP] $skill — 소스 없음"
    continue
  fi
  mkdir -p "$dst"
  cp -r "$src"/* "$dst"/
  echo "[OK]   skills/$skill"
done

# ── scripts ─────────────────────────────────────────────
for s in build-dynamic.sh clean-dynamic.sh clean-worktree.sh; do
  src="$REPO_DIR/scripts/$s"
  if [[ -f "$src" ]]; then
    mkdir -p "$CLAUDE_DIR/scripts"
    cp "$src" "$CLAUDE_DIR/scripts/"
    echo "[OK]   scripts/$s"
  fi
done

# ── references ──────────────────────────────────────────
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
  # 없으면 그대로 복사
  cp "$src_claude_md" "$dst_claude_md"
  echo "[OK]   CLAUDE.md (새로 생성)"
elif ! grep -qF '## Worktree 정책' "$dst_claude_md"; then
  # 기존 파일에 Worktree 정책이 없으면 append
  echo "" >> "$dst_claude_md"
  cat "$src_claude_md" >> "$dst_claude_md"
  echo "[OK]   CLAUDE.md (기존 파일에 추가)"
else
  echo "[SKIP] CLAUDE.md — 이미 Worktree 정책 포함"
fi

echo ""
echo "Done. 빌드까지 하려면: bash scripts/install-and-build.sh"
