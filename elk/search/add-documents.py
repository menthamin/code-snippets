
import time
from elasticsearch import Elasticsearch, helpers
from faker import Faker
from tqdm import tqdm

def create_es_client(hosts=["http://localhost:9200"]):
    """
    Elasticsearch 클라이언트를 생성합니다.
    """
    return Elasticsearch(hosts=hosts)

def generate_actions(fake, total):
    """
    Faker를 사용하여 문서 생성기를 반환합니다.
    """
    for _ in range(total):
        first_name = fake.first_name()
        last_name = fake.last_name()
        yield {
            "_index": "people",
            "_source": {
                "name": f"{first_name} {last_name}"
            }
        }

def bulk_insert(es_client, actions, batch_size=1000):
    """
    Bulk API를 사용하여 문서를 Elasticsearch에 삽입합니다.
    """
    helpers.bulk(es_client, actions, chunk_size=batch_size, request_timeout=200)

def main():
    # Elasticsearch 클라이언트 생성
    es = create_es_client()
    
    # Elasticsearch 연결 확인
    if not es.ping():
        print("Elasticsearch 클러스터에 연결할 수 없습니다. 설정을 확인하세요.")
        return
    
    fake = Faker()
    total_documents = 1000000  # 삽입할 문서 수
    batch_size = 1000          # 배치 크기
    
    print(f"{total_documents}개의 문서를 'people' 인덱스에 삽입합니다...")
    
    # 문서 생성기
    actions = generate_actions(fake, total_documents)
    
    # 진행 상황 표시를 위한 tqdm 사용
    actions = tqdm(actions, total=total_documents, desc="Inserting Documents")
    
    # Bulk 삽입
    bulk_insert(es, actions, batch_size)
    
    print("문서 삽입 완료!")

if __name__ == "__main__":
    main()
