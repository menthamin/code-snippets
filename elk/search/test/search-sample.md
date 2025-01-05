GET /people/_search
{
  "query": {
    "match": {
      "name": "Dav"
    }
  }
}

GET /people/_search
{
  "query": {
    "match": {
      "name": "Bu"
    }
  }
}

GET /people/_search
{
  "query": {
    "term": {
      "name.keyword": "David Buss"
    }
  }
}
