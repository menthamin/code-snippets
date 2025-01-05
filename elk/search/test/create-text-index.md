PUT /people-keyword-v2
{
  "settings": {
    "analysis": {
      "normalizer": {
        "lowercase_normalizer": {
          "type": "custom",
          "filter": ["lowercase"]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "name": {
        "type": "keyword",
        "normalizer": "lowercase_normalizer"
      }
    }
  }
}

POST /_reindex
{
  "source": {
    "index": "people"
  },
  "dest": {
    "index": "people-keyword-v2"
  }
}
