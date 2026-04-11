#!/usr/bin/env bash
# 워크플로우 런타임 로그 정리
# 사용법:
#   clean-log.sh          — 전체 초기화
#   clean-log.sh {작업명}  — 해당 항목만 삭제

RUNTIME=".local/.workflow-runtime.json"

if [ ! -f "$RUNTIME" ]; then
  echo "런타임 로그 없음"
  exit 0
fi

TARGET="$1"

if [ -z "$TARGET" ]; then
  rm -f "$RUNTIME"
  echo "런타임 로그 초기화 완료"
else
  HAS=$(jq -r --arg dir "$TARGET" 'has($dir)' "$RUNTIME" 2>/dev/null)
  if [ "$HAS" != "true" ]; then
    echo "'${TARGET}' 항목 없음"
    exit 0
  fi

  TMP=$(mktemp)
  jq --arg dir "$TARGET" 'del(.[$dir])' "$RUNTIME" > "$TMP" && mv "$TMP" "$RUNTIME"

  # 비어있으면 파일 삭제
  EMPTY=$(jq 'length == 0' "$RUNTIME" 2>/dev/null)
  if [ "$EMPTY" = "true" ]; then
    rm -f "$RUNTIME"
  fi

  echo "'${TARGET}' 항목 삭제 완료"
fi
