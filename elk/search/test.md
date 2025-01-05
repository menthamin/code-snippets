

Elastic Stack를 처음 설정하는 경우, enrollment token을 생성하여 사용해야 합니다. Docker 기반으로 Elasticsearch와 Kibana를 실행 중이므로 아래 단계를 따라 토큰을 가져올 수 있습니다.

### Enrollment Token 가져오는 방법
1. **Elasticsearch 컨테이너 내부에 접근**
   ```bash
   docker exec -it elasticsearch bash
   ```

2. **Enrollment Token 생성**
   Elasticsearch에서 enrollment token을 생성합니다. 아래 명령어를 실행하세요:
   ```bash
   bin/elasticsearch-create-enrollment-token -s kibana
   ```

   이 명령어는 Kibana와 연결할 수 있는 enrollment token을 생성합니다. 생성된 토큰을 복사하세요.

3. **Kibana 설정에 토큰 입력**
   Kibana UI에서 제공된 입력란에 복사한 enrollment token을 붙여넣고 설정을 진행합니다.

### 주의사항
- Elasticsearch가 실행 중이어야 토큰 생성이 가능합니다.
- Kibana가 Elasticsearch와 통신할 수 있도록 환경 설정이 올바른지 확인하세요.

혹시 추가적인 문제가 발생하면 알려주세요!

Elasticsearch에서 **단일 `name` 필드**를 사용하여 전체 이름("David Buss")을 인덱싱하면서도, 이름의 **일부**(예: "Dav", "bu")로 검색 시 해당 문서를 효과적으로 찾을 수 있도록 **Edge N-gram**을 활용하는 방법을 안내드리겠습니다. 이 설정은 **최대 20글자**까지의 이름을 커버하도록 구성됩니다.

## 1. Edge N-gram 이해

### Edge N-gram
- **정의**: 텍스트의 시작 부분(접두사)에서부터 연속된 n개의 문자로 분할하는 방식입니다.
- **장점**:
  - 접두사 기반 검색에 최적화되어 있습니다.
  - 인덱스 크기가 N-gram에 비해 상대적으로 작습니다.
- **단점**:
  - 텍스트의 중간이나 끝 부분의 일치 검색에는 부적합합니다.

### 사용 사례
- **접두사 검색**: 사용자가 이름의 시작 부분을 입력할 때 유용합니다.
  - 예: "Dav" → "David Buss" 매칭
- **부분 검색**: 각 단어(이름과 성)의 시작 부분을 검색할 때 효과적입니다.
  - 예: "bu" → "Buss" 매칭

## 2. 인덱스 매핑 및 분석기 설정

### a. 분석기 설정
Edge N-gram을 사용하여 `name` 필드를 분석하기 위해 커스텀 분석기를 설정합니다. 이 분석기는 다음과 같이 구성됩니다:
- **Tokenizer**: `standard` (또는 `whitespace`) 토크나이저를 사용하여 이름을 개별 단어로 분리합니다.
- **Filter**:
  - `lowercase`: 대소문자 구분 없이 검색할 수 있도록 모든 텍스트를 소문자로 변환합니다.
  - `edge_ngram_filter`: Edge N-gram 필터로, `min_gram=2` 및 `max_gram=20`을 설정하여 2글자부터 최대 20글자까지의 접두사를 생성합니다.

### b. 인덱스 생성 예제

**Kibana Dev Tools** 또는 **curl**을 사용하여 아래와 같이 인덱스를 생성합니다.

#### Kibana Dev Tools 사용 시

1. Kibana에 접속하고, 왼쪽 메뉴에서 **Dev Tools**를 선택합니다.
2. 다음 명령어를 입력하고 실행합니다.

```http
PUT /people
{
  "settings": {
    "analysis": {
      "filter": {
        "edge_ngram_filter": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 20
        }
      },
      "analyzer": {
        "edge_ngram_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "edge_ngram_filter"
          ]
        },
        "whitespace_analyzer": {
          "type": "custom",
          "tokenizer": "whitespace",
          "filter": [
            "lowercase"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "edge_ngram_analyzer",
        "search_analyzer": "whitespace_analyzer",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      }
    }
  }
}
```

#### curl 사용 시

```bash
curl -X PUT "localhost:9200/people" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "analysis": {
      "filter": {
        "edge_ngram_filter": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 20
        }
      },
      "analyzer": {
        "edge_ngram_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "edge_ngram_filter"
          ]
        },
        "whitespace_analyzer": {
          "type": "custom",
          "tokenizer": "whitespace",
          "filter": [
            "lowercase"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "edge_ngram_analyzer",
        "search_analyzer": "whitespace_analyzer",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      }
    }
  }
}
'
```

### c. 설정 설명

- **Settings**:
  - **Analysis**:
    - **Filter**:
      - `edge_ngram_filter`: Edge N-gram 필터로, 2~20글자의 접두사를 생성합니다.
    - **Analyzer**:
      - `edge_ngram_analyzer`: `standard` 토크나이저와 `lowercase`, `edge_ngram_filter`를 사용하여 인덱싱 시 텍스트를 분석합니다.
      - `whitespace_analyzer`: `whitespace` 토크나이저와 `lowercase` 필터를 사용하여 검색 시 텍스트를 분석합니다.

- **Mappings**:
  - **name 필드**:
    - `type: text`: 텍스트 검색을 가능하게 합니다.
    - `analyzer: edge_ngram_analyzer`: 인덱싱 시 Edge N-gram 분석기를 사용합니다.
    - `search_analyzer: whitespace_analyzer`: 검색 시 공백을 기준으로 토크나이즈하여 정확한 검색을 지원합니다.
    - `fields.keyword`: 정확한 일치 검색을 위해 `keyword` 타입의 서브 필드를 추가합니다.

## 3. 데이터 인덱싱

### a. 예제 문서 추가

#### Kibana Dev Tools 사용 시

```http
POST /people/_doc
{
  "name": "David Buss"
}
```

#### curl 사용 시

```bash
curl -X POST "localhost:9200/people/_doc" -H 'Content-Type: application/json' -d'
{
  "name": "David Buss"
}
'
```

### b. 추가 예제 문서

다양한 이름을 테스트하기 위해 추가 문서를 인덱싱할 수 있습니다.

```http
POST /people/_bulk
{ "index": { "_id": 1 } }
{ "name": "Alice Johnson" }
{ "index": { "_id": 2 } }
{ "name": "Bob Smith" }
{ "index": { "_id": 3 } }
{ "name": "Carol Danvers" }
```

또는 `curl`을 사용하여 다음과 같이 인덱싱할 수 있습니다.

```bash
curl -X POST "localhost:9200/people/_bulk" -H 'Content-Type: application/json' -d'
{ "index": { "_id": 1 } }
{ "name": "Alice Johnson" }
{ "index": { "_id": 2 } }
{ "name": "Bob Smith" }
{ "index": { "_id": 3 } }
{ "name": "Carol Danvers" }
'
```

## 4. 검색 쿼리 예제

### a. 부분 검색 (접두사 기반)

**예제 1: "Dav" 입력 시 "David Buss" 반환**

```json
GET /people/_search
{
  "query": {
    "match": {
      "name": "Dav"
    }
  }
}
```

**예제 2: "Bu" 입력 시 "David Buss" 반환**

```json
GET /people/_search
{
  "query": {
    "match": {
      "name": "Bu"
    }
  }
}
```

**예제 3: "Al" 입력 시 "Alice Johnson" 반환**

```json
GET /people/_search
{
  "query": {
    "match": {
      "name": "Al"
    }
  }
}
```

### b. 정확한 일치 검색

**예제: 정확히 "David Buss" 검색**

```json
GET /people/_search
{
  "query": {
    "term": {
      "name.keyword": "David Buss"
    }
  }
}
```

### c. 다중 조건 검색

**예제: "Dav" 또는 "Bu"로 검색하여 여러 결과 반환**

```json
GET /people/_search
{
  "query": {
    "bool": {
      "should": [
        { "match": { "name": "Dav" } },
        { "match": { "name": "Bu" } }
      ]
    }
  }
}
```

## 5. 추가 최적화 및 고려사항

### a. 인덱스 크기 및 성능

- **Edge N-gram의 영향**: `min_gram=2` 및 `max_gram=20` 설정은 텍스트의 다양한 길이를 커버하지만, 인덱스 크기에 영향을 줄 수 있습니다. 특히 긴 이름의 경우 인덱스 크기가 증가할 수 있습니다.
- **성능 최적화**: 필요한 경우 `min_gram`과 `max_gram` 값을 조정하여 인덱스 크기와 검색 성능 사이의 균형을 맞추세요. 일반적으로 `min_gram=2`, `max_gram=20`이 적절합니다.

### b. 검색 정확도 향상

- **Lowercase 필터**: 대소문자 구분 없이 검색할 수 있도록 `lowercase` 필터를 적용했습니다.
- **분리된 검색**: `whitespace_analyzer`를 사용하여 검색어를 정확하게 토크나이즈함으로써 검색의 정확도를 높였습니다.

### c. 다국어 지원

- **언어별 분석기**: 다양한 언어의 이름을 지원해야 하는 경우, 언어별 분석기를 추가로 설정하여 분석의 정확도를 높일 수 있습니다.

### d. 테스트 및 검증

- **다양한 검색 시나리오 테스트**: 실제 사용될 다양한 검색 패턴에 대해 테스트를 진행하여 설정의 적합성을 검증하세요.
- **Kibana Discover 활용**: Kibana의 Discover 탭에서 다양한 쿼리를 실행하여 결과를 시각적으로 확인할 수 있습니다.

## 6. 전체 예제 요약

### 인덱스 생성 및 매핑 설정

```json
PUT /people
{
  "settings": {
    "analysis": {
      "filter": {
        "edge_ngram_filter": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 20
        }
      },
      "analyzer": {
        "edge_ngram_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "edge_ngram_filter"
          ]
        },
        "whitespace_analyzer": {
          "type": "custom",
          "tokenizer": "whitespace",
          "filter": [
            "lowercase"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "edge_ngram_analyzer",
        "search_analyzer": "whitespace_analyzer",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      }
    }
  }
}
```

### 데이터 인덱싱

```json
POST /people/_doc
{
  "name": "David Buss"
}

POST /people/_doc
{
  "name": "Alice Johnson"
}

POST /people/_doc
{
  "name": "Bob Smith"
}

POST /people/_doc
{
  "name": "Carol Danvers"
}
```

### 검색 예제

- **부분 일치 검색 ("Dav")**

  ```json
  GET /people/_search
  {
    "query": {
      "match": {
        "name": "Dav"
      }
    }
  }
  ```

- **부분 일치 검색 ("Bu")**

  ```json
  GET /people/_search
  {
    "query": {
      "match": {
        "name": "Bu"
      }
    }
  }
  ```

- **정확한 일치 검색 ("David Buss")**

  ```json
  GET /people/_search
  {
    "query": {
      "term": {
        "name.keyword": "David Buss"
      }
    }
  }
  ```

## 7. 참고 자료

- [Elasticsearch 공식 문서 - 분석기](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis.html)
- [Elasticsearch 공식 문서 - Edge N-gram Tokenizer](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-edge-ngram-tokenizer.html)
- [Elasticsearch 공식 문서 - 매핑](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html)
- [Elasticsearch 공식 문서 - 검색 쿼리 DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)

---

위의 설정을 통해 **단일 `name` 필드**로 "David Buss"와 같은 이름을 인덱싱하면서도, 이름의 시작 부분을 기준으로 부분 검색 시 해당 문서를 효과적으로 검색할 수 있습니다. Edge N-gram 분석기를 통해 최대 20글자까지의 이름을 커버할 수 있으므로, 다양한 길이의 이름을 처리할 수 있습니다.

추가적인 최적화나 특정 요구 사항이 있을 경우, 상황에 맞게 분석기 설정을 조정하시기 바랍니다. 문제가 발생하거나 추가적인 질문이 있으시면 언제든지 문의해주세요!