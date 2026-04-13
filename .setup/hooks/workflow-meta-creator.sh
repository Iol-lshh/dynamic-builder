#!/usr/bin/env bash
# Skill 호출 시, 해당 스킬이 빌드된 워크플로우이면
# .local/.workflow-runtime.json에 작업 정보를 등록한다.
#
# 빌드 인덱스 탐색 경로 (3-tier scope):
#   1) .dynamic-builder/build-workflow/.build-index.local.json  (project)
#   2) ~/.dynamic-builder/build-workflow/.build-index.local.json (global)

INPUT=$(cat)
SKILL=$(echo "$INPUT" | jq -r '.tool_input.skill // ""')
ARGS=$(echo "$INPUT" | jq -r '.tool_input.args // ""')

if [ -z "$SKILL" ] || [ -z "$ARGS" ]; then
  exit 0
fi

# 빌드 인덱스에서 워크플로우 존재 여부 확인
INDEX_PATHS=(
  ".dynamic-builder/build-workflow/.build-index.local.json"
  "$HOME/.dynamic-builder/build-workflow/.build-index.local.json"
)

FOUND="false"
for idx in "${INDEX_PATHS[@]}"; do
  if [ -f "$idx" ]; then
    HAS=$(jq -r --arg s "$SKILL" '.generated | index($s) != null' "$idx" 2>/dev/null)
    if [ "$HAS" = "true" ]; then
      FOUND="true"
      break
    fi
  fi
done

if [ "$FOUND" != "true" ]; then
  exit 0
fi

RUNTIME=".local/.workflow-runtime.json"
mkdir -p .local

if [ ! -f "$RUNTIME" ]; then
  jq -n --arg dir "$ARGS" --arg wf "$SKILL" \
    '{($dir): {"workflow": $wf, "state": "running"}}' > "$RUNTIME"
else
  TMP=$(mktemp)
  jq --arg dir "$ARGS" --arg wf "$SKILL" \
    '.[$dir] = {"workflow": $wf, "state": "running"}' \
    "$RUNTIME" > "$TMP" && mv "$TMP" "$RUNTIME"
fi

exit 0
