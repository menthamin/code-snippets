로컬 환경에서 Docker Compose를 사용하여 Elasticsearch와 Kibana를 실행하는 방법을 안내드리겠습니다. 아래 단계를 따라 설정을 완료하실 수 있습니다.

## 사전 준비사항

1. **Docker 설치**
   - [Docker 공식 사이트](https://www.docker.com/get-started)에서 Docker Desktop을 다운로드하여 설치하세요.
   
2. **Docker Compose 설치**
   - Docker Desktop을 설치하면 Docker Compose도 함께 설치됩니다. 별도의 설치가 필요하지 않습니다.

## `docker-compose.yml` 파일 작성

프로젝트 디렉토리를 생성하고 그 안에 `docker-compose.yml` 파일을 작성합니다. 아래는 Elasticsearch와 Kibana를 설정하기 위한 예제 `docker-compose.yml` 파일입니다.

```yaml
version: '3.8'

services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.5.0
    container_name: elasticsearch
    environment:
      - node.name=elasticsearch
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"
      - "9300:9300"
    networks:
      - elastic

  kibana:
    image: docker.elastic.co/kibana/kibana:8.5.0
    container_name: kibana
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - "5601:5601"
    networks:
      - elastic
    depends_on:
      - elasticsearch

volumes:
  elasticsearch_data:
    driver: local

networks:
  elastic:
    driver: bridge
```

### 주요 설정 설명

- **Elasticsearch 서비스**
  - `image`: Elasticsearch의 도커 이미지를 지정합니다. 버전은 필요에 따라 조정하세요.
  - `environment`:
    - `discovery.type=single-node`: 단일 노드 모드로 실행합니다.
    - `ES_JAVA_OPTS`: JVM 메모리 설정입니다. 시스템 사양에 따라 조정할 수 있습니다.
  - `ulimits`: 메모리 잠금 설정으로, Elasticsearch의 안정적인 실행을 도와줍니다.
  - `volumes`: 데이터를 지속적으로 저장하기 위한 볼륨 마운트입니다.
  - `ports`: 호스트와 컨테이너 간의 포트 매핑입니다.

- **Kibana 서비스**
  - `image`: Kibana의 도커 이미지를 지정합니다. Elasticsearch와 버전을 맞추는 것이 중요합니다.
  - `environment`:
    - `ELASTICSEARCH_HOSTS`: 연결할 Elasticsearch 호스트를 지정합니다.
  - `depends_on`: Elasticsearch 서비스가 먼저 시작되도록 설정합니다.
  - `ports`: Kibana의 기본 포트인 5601을 호스트에 노출합니다.

## Docker Compose 실행

1. **프로젝트 디렉토리로 이동**
   ```bash
   cd /path/to/your/project-directory
   ```

2. **Docker Compose 실행**
   ```bash
   docker-compose up -d
   ```
   `-d` 옵션은 백그라운드에서 컨테이너를 실행합니다.

3. **실행 상태 확인**
   ```bash
   docker-compose ps
   ```
   각 서비스의 상태를 확인할 수 있습니다.

## Kibana 접근

Docker Compose가 성공적으로 실행되었다면, 웹 브라우저를 열고 [http://localhost:5601](http://localhost:5601)으로 접속하여 Kibana UI에 접근할 수 있습니다.

## 추가 팁

- **로그 확인**
  - Elasticsearch 로그 확인:
    ```bash
    docker-compose logs elasticsearch
    ```
  - Kibana 로그 확인:
    ```bash
    docker-compose logs kibana
    ```
  
- **컨테이너 중지**
  ```bash
  docker-compose down
  ```

- **데이터 유지**
  - `elasticsearch_data` 볼륨을 통해 Elasticsearch 데이터가 컨테이너 재시작 후에도 유지됩니다. 필요 시 볼륨을 삭제하여 데이터를 초기화할 수 있습니다:
    ```bash
    docker volume rm your_project_directory_elasticsearch_data
    ```

## 참고 자료

- [Elasticsearch Docker 공식 문서](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
- [Kibana Docker 공식 문서](https://www.elastic.co/guide/en/kibana/current/docker.html)

위 단계를 따라 로컬 환경에서 Elasticsearch와 Kibana를 손쉽게 실행하고 활용해 보세요. 문제가 발생하거나 추가적인 설정이 필요할 경우, 공식 문서를 참고하시거나 추가 질문을 남겨주세요.