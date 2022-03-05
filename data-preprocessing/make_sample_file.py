"""Linux 샘플 파일 생성 예제 코드"""

import cx_Oracle
import pandas as pd
import os

# https://cross-the-line.tistory.com/9ㅁtory.com/554

# 접속 정보
dsn_info = cx_Oracle.makedsn(oracle_host, oracle_port, oracle_sid)
conn = cx_Oracle.connect(oracle_id, oracle_pw, dsn=dsn_info)

curr = conn.cursor()
query = "select * from hreport.report_info"
curr.execute(query)

col_list = [x[0] for x in curr.description]
df = pd.DataFrame(curr.fetchall(), columns=col_list)
"""
   SN  CREATE_DT           FILE_NM  CTGR TEAM_NM MD_NM  PGM_RESULT REPORT_TYPE  PROFIT_AMT                                      FILE_PATH
0   1 2020-06-01  20200601_00.pptx  여성패션     패션팀   패션2        95.8       라이브방송         762  /home/centos/result/20200601/20200601_00.pptx
1   2 2020-06-01  20200601_02.pptx  일반식품     생활팀   생활2        65.1       데이터방송        1387  /home/centos/result/20200601/20200601_02.pptx
2   3 2020-06-01  20200601_04.pptx    여행     무형팀   무형1        62.2       데이터방송        1067  /home/centos/result/20200601/20200601_04.pptx
3   4 2020-06-01  20200601_06.pptx    렌탈     무형팀   무형2        87.5       트렌드분석        1343  /home/centos/result/20200601/20200601_06.pptx
4   5 2020-06-01  20200601_08.pptx  일반식품     생활팀   생활1        77.1       데이터방송         550  /home/centos/result/20200601/20200601_08.pptx
"""
for row in df.itertuples():
    file_path = row.FILE_PATH
    file_dir, file_nm = os.path.split(file_path)  # https://itmining.tistory.com/122
    os.makedirs(file_dir, exist_ok=True)  # 디렉토리 생성
    make_cmd = "touch {file_path}".format(file_path=file_path)  # 파일 생성
    os.system(make_cmd)
