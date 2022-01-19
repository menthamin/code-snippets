"""쿼리스트링 Parsing 예제 코드
    # 참고자료1: https://sssunho.tistory.com/49 [개발자 Sunho Lee]
    # 참고자료2: https://www.beusable.net/blog/?p=4507 [데이터 분석을 위한 기초, URL 이해하기] 
    # 참고자료3: https://velog.io/@jch9537/URI-URL [URI & URL] / 매우 굿 정리
"""
from urllib.parse import parse_qs, urlparse
from pprint import pprint

url1 = urlparse("https://search.shopping.naver.com/best/category/click?categoryCategoryId=ALL&categoryDemo=A00&categoryRootCategoryId=ALL&period=P1D")
url2 = urlparse("https://search.shopping.naver.com/best/category/click?categoryCategoryId=50000000&categoryDemo=A00&categoryRootCategoryId=50000000&period=P1D")
url3 = urlparse("https://search.shopping.naver.com/best/category/click?categoryCategoryId=50000167&categoryChildCategoryId=&categoryDemo=A00&categoryMidCategoryId=50000167&categoryRootCategoryId=50000000&period=P1D")
url4 = urlparse("https://search.shopping.naver.com/best/category/click?categoryCategoryId=50000778&categoryChildCategoryId=50000778&categoryDemo=A00&categoryMidCategoryId")


dict_url1 = parse_qs(url1.query)
dict_url2 = parse_qs(url2.query)
dict_url3 = parse_qs(url3.query)
dict_url4 = parse_qs(url4.query)

pprint(dict_url1)
pprint(dict_url2)
pprint(dict_url3)
pprint(dict_url4)
