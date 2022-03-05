/* sql trace를 이용한 확인
SQL을 튜닝할 때 가장 많이 사용하는 강력한 도구
autotrace 결과만으로 문제점을 찾을 수 없을 때, sql trace를 이용하면 문제점을 쉽게 찾을 수 있음
*/

-- trace 설정
alter session set sql_trace = true;
select * from dev.emp where empno = 7369;
select * from dual;
alter session set sql_trace = false;

-- 트레이스 파일이 저장되는 경로 출력
select value
from v$diag_info
where name = 'Diag Trace';

-- 트레이스 파일명까지 확인
select value
from v$diag_info
where name = 'Default Trace File';
>>>
/opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_203732.trc

-- 쉘에서 tkprof 명령어로 트레이스파일 확인
tkprof 명령어 간단 사용법: tkprof [트레이스파일] [저장파일]

tkprof /opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_203732.trc report-exam.prf sys=no

-- 결과 예시
Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

Trace file: /opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/ORCLCDB_ora_215795.trc
Sort options: default

********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing 
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************

SQL ID: 5bqkmdmbbawu9 Plan Hash: 2949544139

select * 
from
 dev.emp where empno = 7369


call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0          2          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          2          0           1

Misses in library cache during parse: 0
Optimizer mode: ALL_ROWS
Parsing user id: SYS
Number of plan statistics captured: 1

Rows (1st) Rows (avg) Rows (max)  Row Source Operation
---------- ---------- ----------  ---------------------------------------------------
         1          1          1  TABLE ACCESS BY INDEX ROWID EMP (cr=2 pr=0 pw=0 time=121 us starts=1 cost=1 size=38 card=1)
         1          1          1   INDEX UNIQUE SCAN PK_EMP (cr=1 pr=0 pw=0 time=63 us starts=1 cost=0 size=0 card=1)(object id 73825)

********************************************************************************
