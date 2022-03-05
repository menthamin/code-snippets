/* 
Autotrace

Sqlplus에서 SQL의 실제 실행 결과와 실행 계획, 실행 통계를 확인하는 방법
- 실행 결과: 결과 집합 (쿼리 실제 실행)
- 실행 계획: 쿼리의 실행 계획 (explain plan의 실행 계획, 쿼리를 실제로 실행하지 않음)
- 실행 통계: 쿼리를 실제로 실행한 결과의 실행 통계 (논리적 블록 읽기(버퍼캐시), 디스크에서 블록 읽은 횟수 등)

- 실행 결과 / 계획 / 통계 예시 

SQL>select * from dev.emp where empno = '7369';

     EMPNO ENAME      JOB              MGR HIREDATE         SAL       COMM     DEPTNO
---------- ---------- --------- ---------- --------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 17-DEC-80        800                    20


Execution Plan
----------------------------------------------------------
Plan hash value: 2949544139

--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("EMPNO"=7369)

Statistics
----------------------------------------------------------
         39  recursive calls
          0  db block gets
         59  consistent gets
          0  physical reads
          0  redo size
        961  bytes sent via SQL*Net to client
        393  bytes received via SQL*Net from client
          1  SQL*Net roundtrips to/from client
          5  sorts (memory)
          0  sorts (disk)
          1  rows processed

*/

-- sqlplus 에서 명령어를 입력해야 합니다.

-- SQL을 실행하고 결과 집합과 함꼐 예상 실행계획을 출력
set autotrace on;
select * from dev.emp where empno = '7369';

-- SQL을 실행하고 결과집합과 함꼐 예상 실행계획을 출력
set autotrace on explain;
select * from dev.emp where empno = '7369';

-- SQL을 실행하고 결과집합과 함께 실행통계 출력
set autotrace on statistics;
select * from dev.emp where empno = '7369';

-- SQL을 실행하지만 결과집합을 출력하지 않고, 예상 실행계획과 실행통계만 출력
set autotrace traceonly;
select * from dev.emp where empno = '7369';

-- SQL을 실행하지 않고 예상 실행계획만 출력
set autotrace traceonly explain;
select * from dev.emp where empno = '7369';

-- SQL을 실행하지만 결과집합을 출력하지 않고 실행통계만 출력;
set autotrace traceonly statistics
select * from dev.emp where empno = '7369';

-- 출처: 친절한SQL 튜닝(조시형 저, 디비안) 535page

/* 
Autotrace로 실행계획만 확인한다면 plan_table만 생성되어 있으면 되지만
실행통계를 확인하려면 아래 3개 뷰에대한 권한이 필요합니다.

# 실행 통계확인시 권한이 필요한 뷰 3가지
SELECT * FROM v$sesstat;
SELECT * FROM v$statname;
SELECT * FROM v$mystat;

# 권한 부여하기
SQL>
@?/sqlplus/admin/plustrace.sql
grant plustrace to scott;
*/
