# Figma API 접근 가이드

## 인증 정보

- Figma Personal Access Token은 `settings.local.json`의 `env.FIGMA_TOKEN`에 설정되어 있다
- 환경변수 `$FIGMA_TOKEN`으로 접근 가능

## Figma URL에서 파일/노드 ID 추출

Figma URL 형식:
```
https://www.figma.com/design/<FILE_KEY>/<FILE_NAME>?node-id=<NODE_ID>
https://www.figma.com/file/<FILE_KEY>/<FILE_NAME>?node-id=<NODE_ID>
```

- `FILE_KEY`: URL 경로의 3번째 세그먼트
- `NODE_ID`: 쿼리 파라미터 `node-id` 값 (URL 인코딩된 형태: `1-2` → API에서는 `1:2`로 변환)

## API 호출 방법

**파일 정보 조회:**
```bash
curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/files/<FILE_KEY>"
```

**특정 노드 조회:**
```bash
curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/files/<FILE_KEY>/nodes?ids=<NODE_ID>"
```

**이미지 내보내기:**
```bash
curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/images/<FILE_KEY>?ids=<NODE_ID>&format=png&scale=2"
```

## 캐시

Figma API는 rate limit이 있으므로, 응답을 로컬에 캐시하여 재사용한다.

### 캐시 디렉토리 구조

```
~/.claude/figma-cache/
└── <FILE_KEY>/
    ├── file.json              # 파일 정보 전체 (/v1/files/<FILE_KEY>)
    ├── nodes/
    │   └── <NODE_ID>.json     # 개별 노드 (/v1/files/<FILE_KEY>/nodes?ids=<NODE_ID>)
    └── images/
        └── <NODE_ID>.png      # 내보낸 이미지
```

- `FILE_KEY`별로 폴더를 분리한다
- `NODE_ID`에서 `:`는 파일명으로 사용할 수 없으므로 `-`로 변환하여 저장한다 (예: `1:2` → `1-2.json`)

### 캐시 사용 절차

1. **조회 전 캐시 확인** — 해당 경로에 캐시 파일이 존재하면 API 호출 없이 캐시를 사용한다
2. **캐시 미스 시 API 호출 후 저장** — 응답을 캐시 경로에 저장한다
3. **강제 갱신** — 사용자가 명시적으로 요청한 경우에만 캐시를 무시하고 재호출한다

### 캐시 API 호출 패턴

**파일 정보 (캐시 → API fallback):**
```bash
CACHE_DIR="/Users/munpia/.claude/figma-cache/<FILE_KEY>"
mkdir -p "$CACHE_DIR/nodes" "$CACHE_DIR/images"

if [ -f "$CACHE_DIR/file.json" ]; then
  cat "$CACHE_DIR/file.json"
else
  curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/files/<FILE_KEY>" | tee "$CACHE_DIR/file.json"
fi
```

**특정 노드 (캐시 → API fallback):**
```bash
NODE_FILE="$CACHE_DIR/nodes/<NODE_ID_WITH_DASH>.json"
if [ -f "$NODE_FILE" ]; then
  cat "$NODE_FILE"
else
  curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/files/<FILE_KEY>/nodes?ids=<NODE_ID>" | tee "$NODE_FILE"
fi
```

**이미지 내보내기 (캐시 → API fallback):**
```bash
IMG_FILE="$CACHE_DIR/images/<NODE_ID_WITH_DASH>.png"
if [ -f "$IMG_FILE" ]; then
  echo "캐시 사용: $IMG_FILE"
else
  IMG_URL=$(curl -s -H "X-Figma-Token: $FIGMA_TOKEN" "https://api.figma.com/v1/images/<FILE_KEY>?ids=<NODE_ID>&format=png&scale=2" | jq -r '.images["<NODE_ID>"]')
  curl -s -o "$IMG_FILE" "$IMG_URL"
fi
```

## 주의사항

- WebFetch로 www.figma.com에 접근하면 인증 실패한다. **반드시 curl + `$FIGMA_TOKEN` 헤더**를 사용할 것
- API 도메인은 `api.figma.com`이다 (www.figma.com이 아님)
- 응답이 클 경우 `python3 -m json.tool`로 포맷팅하거나, `jq`로 필요한 부분만 추출
- `node-id`의 `-`는 API 호출 시 `:`로 변환해야 한다 (URL 인코딩: `%3A`)
- **캐시된 응답이 오래된 경우** 사용자에게 갱신 여부를 확인한다