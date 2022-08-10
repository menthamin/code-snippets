# 선행 작업
- Git-sync용 Docker image 생성 필요
- MacOS 기준
```bash
# Repository clone 
git clone https://github.com/kubernetes/git-sync.git
cd git-sync

# Make git-sync image (MaxOs: GOARCH=arm64)
make container REGISTRY=registry VERSION=tag \
GOOS=linux GOARCH=arm64

# Check image
docker image list | grep git
>> registry/git-sync  tag__linux_arm64   72323b28b4d6 ...

# Delete git-sync repository
cd ..
rm -r git-sync
```
[- 참고 링크: https://github.com/kubernetes/git-sync]()

# Git-sync 테스트
### 실행
```bash
export USER_ID=$(id -u)
mkdir -p config dags plugins
docker-compose up -d
```

### 종료
```
docker-compose down
rm -r config dags plugins

sudo rm -r config/*
ls -lh config
```
