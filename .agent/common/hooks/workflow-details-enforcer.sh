#!/usr/bin/env bash
# Write/Edit/MultiEdit 호출 시, 해당 워크플로우 스텝의 details 파일이
# 모두 pending에 있는지 검증한다. 미읽은 파일이 있으면 차단(exit 2)한다.
# 통과 시 pending에서 소비하여 reads.{step}에 기록한다.
#
# 작업 정보: .local/.workflow-runtime.json
# 매니페스트: ~/.dynamic-builder/build-workflow/.workflow-details-manifest.local.json
# 읽기 로그: .local/{작업명}/.workflow-log.json

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

PATTERN='\.local/([^/]+)/([^/]+)\.md$'
if [[ ! "$FILE_PATH" =~ $PATTERN ]]; then
  exit 0
fi

OUTPUT_DIR_NAME="${BASH_REMATCH[1]}"
STEP="${BASH_REMATCH[2]}"

# runtime에서 워크플로우 이름 조회
RUNTIME=".local/.workflow-runtime.json"
if [ ! -f "$RUNTIME" ]; then
  exit 0
fi

WORKFLOW=$(jq -r --arg dir "$OUTPUT_DIR_NAME" \
  '.[$dir].workflow // ""' "$RUNTIME" 2>/dev/null)

if [ -z "$WORKFLOW" ]; then
  exit 0
fi

# 매니페스트에서 해당 스텝의 details 목록
MANIFEST="$HOME/.dynamic-builder/build-workflow/.workflow-details-manifest.local.json"
if [ ! -f "$MANIFEST" ]; then
  exit 0
fi

DETAILS=$(jq -r --arg wf "$WORKFLOW" --arg st "$STEP" \
  '(.[$wf][$st] // []) | .[]' "$MANIFEST" 2>/dev/null)

if [ -z "$DETAILS" ]; then
  exit 0
fi

# pending 확인
LOG_FILE=".local/${OUTPUT_DIR_NAME}/.workflow-log.json"
UNREAD=""

for d in $DETAILS; do
  IN_PENDING="false"
  if [ -f "$LOG_FILE" ]; then
    IN_PENDING=$(jq -r --arg d "$d" \
      'if (.pending | index($d)) then "true" else "false" end' \
      "$LOG_FILE" 2>/dev/null)
  fi
  if [ "$IN_PENDING" != "true" ]; then
    UNREAD="${UNREAD}\n  - ${d}"
  fi
done

if [ -n "$UNREAD" ]; then
  MSG="⚠️ [workflow-details-enforcer] 스텝 '${STEP}'의 details 파일을 먼저 Read하세요.\\n미읽은 파일:${UNREAD}\\n\\n해당 파일 경로: .claude/skills/${WORKFLOW}/references/ 하위"
  echo "{\"decision\":\"block\",\"reason\":\"${MSG}\"}"
  exit 2
fi

# 통과: pending 소비 → reads.{step} 기록
TMP=$(mktemp)
jq --arg st "$STEP" --argjson details "$(echo "$DETAILS" | jq -R -s 'split("\n") | map(select(. != ""))')" '
  .reads[$st] = $details |
  reduce $details[] as $d (.; .pending |= (del(.[index($d)])))
' "$LOG_FILE" > "$TMP" && mv "$TMP" "$LOG_FILE"

exit 0
