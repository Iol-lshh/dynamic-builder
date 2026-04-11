#!/usr/bin/env bash
# Read 호출 시 워크플로우 details 파일 읽기를 추적한다.
# 매칭 패턴: */skills/{workflow}/references/{detail}.md
# 기록 위치: .local/{workflow}/.workflow-logs.json

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# skills/{workflow}/references/{detail}.md 패턴 매칭
if [[ "$FILE_PATH" =~ /skills/([^/]+)/references/([^/]+)$ ]]; then
  WORKFLOW="${BASH_REMATCH[1]}"
  DETAIL="${BASH_REMATCH[2]}"

  LOG_DIR=".local/${WORKFLOW}"
  LOG_FILE="${LOG_DIR}/.workflow-logs.json"

  mkdir -p "$LOG_DIR"

  if [ -f "$LOG_FILE" ]; then
    TMP=$(mktemp)
    jq --arg d "$DETAIL" '.reads[$d] = true' "$LOG_FILE" > "$TMP" && mv "$TMP" "$LOG_FILE"
  else
    echo "{\"reads\":{\"${DETAIL}\":true}}" | jq '.' > "$LOG_FILE"
  fi
fi

exit 0
