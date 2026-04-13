#!/usr/bin/env bash
# Read 호출 시 워크플로우 details 파일 읽기를 pending에 추가한다.
# .local/.workflow-runtime.json에서 출력 디렉토리를 찾고,
# .local/{작업명}/.workflow-log.json에 기록한다.
#
# 매칭 패턴: */skills/{workflow}/references/{detail}

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

if [[ ! "$FILE_PATH" =~ /skills/([^/]+)/references/([^/]+)$ ]]; then
  exit 0
fi

WORKFLOW="${BASH_REMATCH[1]}"
DETAIL="${BASH_REMATCH[2]}"

RUNTIME=".local/.workflow-runtime.json"
if [ ! -f "$RUNTIME" ]; then
  echo "{\"decision\":\"block\",\"reason\":\"⚠️ [workflow-details-read-tracker] 워크플로우 '${WORKFLOW}'가 running 상태가 아닙니다. 워크플로우를 먼저 시작하세요.\"}"
  exit 2
fi

# runtime에서 해당 워크플로우의 출력 디렉토리 찾기
OUTPUT_DIR_NAME=$(jq -r --arg wf "$WORKFLOW" \
  'to_entries[] | select(.value.workflow == $wf and .value.state == "running") | .key' \
  "$RUNTIME" 2>/dev/null)

if [ -z "$OUTPUT_DIR_NAME" ]; then
  echo "{\"decision\":\"block\",\"reason\":\"⚠️ [workflow-details-read-tracker] 워크플로우 '${WORKFLOW}'가 running 상태가 아닙니다. 워크플로우를 먼저 시작하세요.\"}"
  exit 2
fi

LOG_FILE=".local/${OUTPUT_DIR_NAME}/.workflow-log.json"

if [ -f "$LOG_FILE" ]; then
  TMP=$(mktemp)
  jq --arg d "$DETAIL" '.pending += [$d]' "$LOG_FILE" > "$TMP" && mv "$TMP" "$LOG_FILE"
else
  mkdir -p ".local/${OUTPUT_DIR_NAME}"
  jq -n --arg d "$DETAIL" '{"pending":[$d],"reads":{}}' > "$LOG_FILE"
fi

exit 0
