#!/usr/bin/env bash
# clean-worktree — 작업 완료된 worktree와 연결 브랜치를 삭제한다
# 사용법:
#   ./clean-worktree.sh                # 대화형: 삭제할 worktree 선택
#   ./clean-worktree.sh <name>         # 지정한 worktree 삭제
#   ./clean-worktree.sh --all          # 전체 worktree 삭제
#   ./clean-worktree.sh --prunable     # prunable 상태만 정리
#   ./clean-worktree.sh --dry-run ...  # 실제 삭제 없이 대상만 표시

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKTREE_DIR="$REPO_ROOT/.claude/worktrees"

dry_run=false
mode=""
target_name=""

for arg in "$@"; do
  case "$arg" in
    --dry-run)   dry_run=true ;;
    --all)       mode="all" ;;
    --prunable)  mode="prunable" ;;
    --help|-h)
      sed -n '2,7p' "$0" | sed 's/^# //'
      exit 0
      ;;
    -*)          echo "Unknown option: $arg"; exit 1 ;;
    *)           target_name="$arg"; mode="single" ;;
  esac
done

cd "$REPO_ROOT"

# worktree 목록 수집 (.claude/worktrees 하위만)
collect_worktrees() {
  git worktree list --porcelain | awk '
    /^worktree / { path=$2 }
    /^branch /   { branch=$2; if (path ~ /\.claude\/worktrees\//) print path "\t" branch }
    /^prunable/  { prunable[path]=1 }
  '
}

collect_prunable() {
  git worktree list --porcelain | awk '
    /^worktree / { path=$2 }
    /^branch /   { branch=$2 }
    /^prunable/  { if (path ~ /\.claude\/worktrees\//) print path "\t" branch }
  '
}

remove_worktree() {
  local wt_path="$1"
  local branch="$2"
  local name
  name="$(basename "$wt_path")"
  local short_branch="${branch#refs/heads/}"

  if $dry_run; then
    echo "[dry-run] 삭제 대상: $name (branch: $short_branch)"
    return
  fi

  echo "삭제 중: $name (branch: $short_branch)"

  # worktree 제거 (force: 변경사항 무시)
  if git worktree list | grep -q "$wt_path"; then
    git worktree remove --force "$wt_path" 2>/dev/null || {
      echo "  ⚠ worktree 디렉토리 제거 실패, 수동 정리 시도..."
      rm -rf "$wt_path"
      git worktree prune
    }
  fi

  # 연결 브랜치 삭제
  if git show-ref --verify --quiet "refs/heads/$short_branch" 2>/dev/null; then
    git branch -D "$short_branch" 2>/dev/null && \
      echo "  브랜치 삭제: $short_branch" || \
      echo "  ⚠ 브랜치 삭제 실패: $short_branch"
  fi

  echo "  완료"
}

# 현재 worktree 안에서 실행 중인지 확인
current_wt=""
if [[ "$PWD" == "$WORKTREE_DIR"/* ]]; then
  current_wt="$(basename "$PWD")"
fi

case "$mode" in
  single)
    wt_path="$WORKTREE_DIR/$target_name"
    if [[ ! -d "$wt_path" ]]; then
      # prunable일 수도 있으니 git worktree list에서 확인
      branch=$(git worktree list --porcelain | awk -v p="$wt_path" '
        /^worktree / { path=$2 }
        /^branch /   { if (path == p) print $2 }
      ')
      if [[ -z "$branch" ]]; then
        echo "Error: worktree '$target_name' not found"
        exit 1
      fi
      # prunable — prune 후 브랜치만 삭제
      git worktree prune
      short="${branch#refs/heads/}"
      if git show-ref --verify --quiet "refs/heads/$short" 2>/dev/null; then
        if $dry_run; then
          echo "[dry-run] 브랜치 삭제 대상: $short"
        else
          git branch -D "$short" && echo "브랜치 삭제: $short"
        fi
      fi
      exit 0
    fi

    if [[ "$target_name" == "$current_wt" ]]; then
      echo "Error: 현재 작업 중인 worktree는 삭제할 수 없습니다: $target_name"
      exit 1
    fi

    branch=$(git worktree list --porcelain | awk -v p="$wt_path" '
      /^worktree / { path=$2 }
      /^branch /   { if (path == p) print $2 }
    ')
    remove_worktree "$wt_path" "${branch:-unknown}"
    ;;

  all)
    entries=$(collect_worktrees)
    if [[ -z "$entries" ]]; then
      echo "삭제할 worktree가 없습니다."
      exit 0
    fi

    count=0
    while IFS=$'\t' read -r wt_path branch; do
      name="$(basename "$wt_path")"
      if [[ "$name" == "$current_wt" ]]; then
        echo "건너뜀 (현재 작업 중): $name"
        continue
      fi
      remove_worktree "$wt_path" "$branch"
      ((count++))
    done <<< "$entries"
    echo "---"
    echo "총 ${count}개 worktree 삭제 완료"
    ;;

  prunable)
    entries=$(collect_prunable)
    if [[ -z "$entries" ]]; then
      echo "정리할 prunable worktree가 없습니다."
      exit 0
    fi

    git worktree prune
    count=0
    while IFS=$'\t' read -r wt_path branch; do
      short="${branch#refs/heads/}"
      if git show-ref --verify --quiet "refs/heads/$short" 2>/dev/null; then
        if $dry_run; then
          echo "[dry-run] 브랜치 삭제 대상: $short"
        else
          git branch -D "$short" && echo "브랜치 삭제: $short"
        fi
      fi
      ((count++))
    done <<< "$entries"
    echo "---"
    echo "총 ${count}개 prunable worktree 정리 완료"
    ;;

  "")
    # 대화형 모드: 목록 표시 후 선택
    entries=$(collect_worktrees)
    if [[ -z "$entries" ]]; then
      echo "삭제할 worktree가 없습니다."
      exit 0
    fi

    echo "=== Worktree 목록 ==="
    i=1
    declare -a paths=()
    declare -a branches=()
    while IFS=$'\t' read -r wt_path branch; do
      name="$(basename "$wt_path")"
      short="${branch#refs/heads/}"
      marker=""
      if [[ "$name" == "$current_wt" ]]; then
        marker=" (현재)"
      fi
      echo "  $i) $name → $short$marker"
      paths+=("$wt_path")
      branches+=("$branch")
      ((i++))
    done <<< "$entries"

    echo ""
    read -rp "삭제할 번호 (쉼표 구분, a=전체, q=취소): " choice

    if [[ "$choice" == "q" ]]; then
      echo "취소됨"
      exit 0
    fi

    if [[ "$choice" == "a" ]]; then
      indices=()
      for ((j=0; j<${#paths[@]}; j++)); do
        indices+=("$j")
      done
    else
      IFS=',' read -ra selections <<< "$choice"
      indices=()
      for sel in "${selections[@]}"; do
        sel="$(echo "$sel" | tr -d ' ')"
        if [[ "$sel" =~ ^[0-9]+$ ]] && (( sel >= 1 && sel <= ${#paths[@]} )); then
          indices+=("$((sel-1))")
        else
          echo "잘못된 선택: $sel"
          exit 1
        fi
      done
    fi

    count=0
    for idx in "${indices[@]}"; do
      name="$(basename "${paths[$idx]}")"
      if [[ "$name" == "$current_wt" ]]; then
        echo "건너뜀 (현재 작업 중): $name"
        continue
      fi
      remove_worktree "${paths[$idx]}" "${branches[$idx]}"
      ((count++))
    done
    echo "---"
    echo "총 ${count}개 worktree 삭제 완료"
    ;;
esac
