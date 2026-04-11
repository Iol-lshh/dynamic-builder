#!/usr/bin/env bash
# Write/Edit/MultiEdit 호출 시, 해당 워크플로우 스텝의 details 파일이
# 모두 Read되었는지 검증한다. 미읽은 파일이 있으면 차단(exit 2)한다.
#
# 매니페스트: ~/.claude/dynamic-builder/build-workflow/.workflow-details-manifest.json
# 읽기 로그: .local/{workflow}/.workflow-logs.json

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# 쓰기 대상이 .local/{workflow}/{step}.md 인지 확인
# 절대경로·상대경로 모두 처리
PATTERN='\.local/([^/]+)/([^/]+)\.md$'
if [[ ! "$FILE_PATH" =~ $PATTERN ]]; then
  exit 0
fi

WORKFLOW="${BASH_REMATCH[1]}"
STEP="${BASH_REMATCH[2]}"

# 로그 파일 자체는 스킵
if [[ "$STEP" == ".workflow-logs" ]]; then
  exit 0
fi

# 매니페스트 로드
MANIFEST="$HOME/.claude/dynamic-builder/build-workflow/.workflow-details-manifest.json"
if [ ! -f "$MANIFEST" ]; then
  exit 0
fi

# 해당 워크플로우·스텝의 details 목록 추출
DETAILS=$(jq -r --arg wf "$WORKFLOW" --arg st "$STEP" \
  '(.[$wf][$st] // []) | .[]' "$MANIFEST" 2>/dev/null)

if [ -z "$DETAILS" ]; then
  exit 0
fi

# 읽기 로그 확인
LOG_FILE=".local/${WORKFLOW}/.workflow-logs.json"
UNREAD=""

for d in $DETAILS; do
  READ_FLAG="false"
  if [ -f "$LOG_FILE" ]; then
    READ_FLAG=$(jq -r --arg d "$d" '.reads[$d] // false' "$LOG_FILE" 2>/dev/null)
  fi
  if [ "$READ_FLAG" != "true" ]; then
    UNREAD="${UNREAD}\n  - ${d}"
  fi
done

if [ -n "$UNREAD" ]; then
  MSG="⚠️ [workflow-details-enforcer] 스텝 '${STEP}'의 details 파일을 먼저 Read하세요.\\n미읽은 파일:${UNREAD}\\n\\n해당 파일 경로: .claude/skills/${WORKFLOW}/references/ 하위"
  echo "{\"decision\":\"block\",\"reason\":\"${MSG}\"}"
  exit 2
fi

exit 0
