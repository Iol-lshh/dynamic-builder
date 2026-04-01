#!/usr/bin/env bash
# install-hooks — hooks와 settings.json을 ~/.claude에 설치한다
# 사용법:
#   bash scripts/install-hooks.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "=== Install Hooks ==="

# ── hooks 복사 ──────────────────────────────────────────
src_hooks="$REPO_DIR/.claude/hooks"
dst_hooks="$CLAUDE_DIR/hooks"
if [[ -d "$src_hooks" ]]; then
  mkdir -p "$dst_hooks"
  cp -r "$src_hooks"/* "$dst_hooks"/
  echo "[OK]   hooks/"
fi

# ── settings.json 머지 ──────────────────────────────────
src_settings="$REPO_DIR/.claude/settings.json"
dst_settings="$CLAUDE_DIR/settings.json"

if [[ ! -f "$src_settings" ]]; then
  echo "[SKIP] settings.json — 소스 없음"
  exit 0
fi

if [[ ! -f "$dst_settings" ]]; then
  cp "$src_settings" "$dst_settings"
  echo "[OK]   settings.json (새로 생성)"
else
  # jq가 있으면 deep merge, 없으면 수동 안내
  if command -v jq &>/dev/null; then
    # permissions.allow: 합집합
    # hooks: 소스 기준으로 덮어쓰기 (hook 정의는 리포 것을 정본으로 취급)
    merged=$(jq -s '
      .[0] as $dst | .[1] as $src |
      {
        permissions: {
          allow: (($dst.permissions.allow // []) + ($src.permissions.allow // []) | unique)
        },
        hooks: ($dst.hooks // {}) * ($src.hooks // {})
      }
    ' "$dst_settings" "$src_settings")
    echo "$merged" | jq '.' > "$dst_settings"
    echo "[OK]   settings.json (머지 완료)"
  else
    echo "[WARN] jq가 설치되어 있지 않아 자동 머지를 할 수 없습니다."
    echo "       수동으로 아래 두 파일을 비교하여 머지하세요:"
    echo "         소스: $src_settings"
    echo "         대상: $dst_settings"
  fi
fi

echo ""
echo "Done."
