# figma-fetch-details.md

스텝: fetch-figma
에이전트: orchestrator (type: shell)

---

## 목적

Figma URL로부터 화면 기획서 데이터를 가져와 분석에 필요한 노드만 추출한 JSON을 생성한다.

## 처리 순서

### 0. Figma Token 획득

아래 순서로 토큰을 확인한다. 먼저 발견된 값을 사용한다.

1. **settings.local.json 확인**: `~/.claude/settings.local.json`을 읽고 `env.FIGMA_TOKEN` 키가 있으면 사용
2. **settings.json 확인**: `~/.claude/settings.json`을 읽고 `env.FIGMA_TOKEN` 키가 있으면 사용
3. **환경변수 확인**: `$FIGMA_TOKEN`이 설정되어 있으면 사용
4. **사용자에게 요청**: 위 모두 없으면 AskUserQuestion으로 토큰을 요청한다
   - 질문: "Figma Personal Access Token을 입력해주세요. (Figma > Settings > Personal access tokens에서 생성)"
5. **등록 제안**: 토큰을 받으면 재사용을 위해 settings.local.json에 등록할지 묻는다
   - 질문: "이 토큰을 settings.local.json에 저장하여 다음에도 재사용할까요?"
   - 승인 시: `~/.claude/settings.local.json`의 `env.FIGMA_TOKEN`에 저장
   - 거부 시: 현재 세션에서만 사용

**settings.local.json 저장 형식:**
```json
{
  "env": {
    "FIGMA_TOKEN": "<토큰값>"
  }
}
```

기존 settings.local.json에 다른 키가 있으면 `env.FIGMA_TOKEN`만 추가/갱신한다. 파일이 없으면 새로 생성한다.

### 1. URL 파싱

- 입력: Figma URL (예: `https://www.figma.com/design/<FILE_KEY>/...?node-id=<NODE_ID>`)
- FILE_KEY: URL 경로에서 `/design/` 또는 `/file/` 뒤의 세그먼트
- NODE_ID: 쿼리 파라미터 `node-id` 값. URL 인코딩된 경우 디코딩한다 (`%3A` -> `:`)
- FILE_KEY 또는 NODE_ID 파싱 실패 시 에러 메시지를 출력하고 종료한다

### 2. 캐시 확인

- 캐시 경로: `/Users/munpia/.claude/figma-cache/<FILE_KEY>/<NODE_ID_SAFE>.json`
  - NODE_ID_SAFE: NODE_ID의 `:` -> `-` 변환
- `force-refresh`가 `true`이면 캐시를 무시하고 3단계(API 호출)로 바로 진행한다 (호출 후 캐시 갱신)
- `force-refresh`가 `false`(기본값)이면:
  - 캐시 파일이 존재하면 API 호출을 건너뛰고 4단계(전처리)로 진행한다
  - 캐시 파일이 손상(JSON 파싱 실패)된 경우 삭제 후 API를 재호출한다

### 3. API 호출

- 0단계에서 획득한 토큰을 사용한다
- API 요청:
  ```
  curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
    "https://api.figma.com/v1/files/<FILE_KEY>/nodes?ids=<NODE_ID>"
  ```
- 에러 처리:
  - HTTP 429 (Rate Limit): 60초 대기 후 1회 재시도. 재실패 시 종료
  - HTTP 4xx/5xx: 에러 코드와 응답 본문을 출력하고 종료
  - 네트워크 타임아웃: 30초 타임아웃 설정. 실패 시 1회 재시도 후 종료
- 성공 시 캐시 디렉토리를 생성하고 응답을 캐시 파일에 저장한다

### 4. 전처리 (분석 필수 노드 추출)

API 응답 또는 캐시 JSON에서 분석에 필요한 정보만 추출한다.

추출 대상:
1. **화면 이름**: 최상위 노드의 `name` 필드
2. **frame/component 노드**: `type`이 `FRAME`, `COMPONENT`, `COMPONENT_SET`, `INSTANCE`인 노드. 각 노드에서 `id`, `name`, `type`, `children` 구조를 보존한다
3. **text 노드**: `type`이 `TEXT`인 노드. `id`, `name`, `characters`, `style` 필드를 추출한다
4. **variant/state 정보**: `COMPONENT_SET` 노드의 `componentPropertyDefinitions`, `INSTANCE` 노드의 `componentProperties`를 추출한다

추출 대상 외 필드(`absoluteBoundingBox`, `fills`, `strokes`, `effects`, `blendMode` 등 시각적 스타일 정보)는 제거한다.

### 산출물

- 파일: `figma-data.json`
- 구조: 전처리된 노드 트리 (분석 필수 필드만 포함)
