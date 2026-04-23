# 증거 규격: git 명령

git 이력·diff·브랜치 상태를 근거로 주장할 때 제시해야 하는 증거 포맷.

## 필수 항목

- 실행한 git 명령 전체
- 작업 디렉토리 (저장소 루트)
- 출력 원문

## 포맷

```
$ git {subcommand} {args}
(cwd: {path})

{출력 원문 그대로}
```

커밋을 인용할 경우 해시·author·subject를 포함한 `git log --oneline` 또는 `git show` 원문을 그대로 제시한다.

## 금지 사항

- "최근 커밋은 모두 refactor입니다" 등 요약만 제시
- 커밋 해시 없이 "최근 N개 커밋"만 언급
- diff 발췌 후 "... 이하 생략 ..." 처리
- `git log --all` 등 넓은 범위 결과의 부분 재구성
