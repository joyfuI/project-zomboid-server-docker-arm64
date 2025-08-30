# project-zomboid-server-docker-arm64

ARM64 용 프로젝트 좀보이드 서버 도커 이미지

관련 잡담은 [https://blog.joyfui.com/1295](https://blog.joyfui.com/1295)

### 사용법

```bash
docker run -d \
  --name project-zomboid-server \
  -p 16261:16261/udp \
  -p 16262:16262/udp \
  -v <zomboid-folder>:/home/steam/Zomboid \  # 서버 데이터가 저장되는 경로
  -v <workshop-folder>:/home/steam/pzserver/steamapps/workshop \  # 스팀 워크샵(모드) 파일이 저장되는 경로
  -e TZ=Asia/Seoul \  # 타임존
  -e SERVERNAME=servertest \  # 서버 이름(디렉터리 이름)
  --restart unless-stopped \
  ghcr.io/joyfui/project-zomboid-server-docker-arm64:latest
```

주석을 참고해서 환경변수와 볼륨 마운트 경로를 적절하게 수정해서 컨테이너를 생성한 후

```bash
docker exec -it project-zomboid-server /bin/bash
```

위 명령어로 컨테이너 내부로 들어간 뒤에

```bash
./run.sh
```

위 명령어로 콘솔에 진입할 수 있습니다. 컨테이너 최초 실행 시 서버 다운로드에 시간이 소요되며 다운로드 완료 전까지 콘솔 진입이 안 됩니다.\
최초 서버 실행 후 admin 비밀번호 지정이 필요합니다. 콘솔에 진입해서 지정해 주세요.

백그라운드에서도 서버 실행을 유지하기 위해 screen을 사용했습니다. 따라서 서버 실행 후 다시 셸로 나오고 싶으면 screen 사용법과 같이 "Ctrl + a, d"를 입력하면 서버를 실행한 채로 나올 수 있습니다.

서버가 죽거나 종료되면 10초 후 자동으로 다시 시작합니다.

서버 설정에 대한 정보는 [https://pzwiki.net/wiki/Dedicated_server](https://pzwiki.net/wiki/Dedicated_server)

### 기타

- 서버 최초 실행 시 admin 비밀번호 지정 때문에 사용자의 키 입력이 필수인데 이 때문에 반드시 한번은 콘솔에 진입해야 한다. 해결하려면 최초 실행 전에 외부에서 직접 DB에 비밀번호를 때려 넣어야 하나 싶긴 한데 해싱된 값이 저장되는 듯하여 실패...
- 백그라운드에 있는 서버에 직접 명령을 보낼 수 있으면 좋겠는데 FIFO를 시도해 봤지만, 블록 문제로 실패했다. 흠...

### 참고 링크

- [https://steamcommunity.com/app/108600/discussions/1/3415433168012191380/#c4522260857741595094](https://steamcommunity.com/app/108600/discussions/1/3415433168012191380/#c4522260857741595094)
