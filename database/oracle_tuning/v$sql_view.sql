/*
V$SQL 뷰는 오라클 라이브러리캐시(코드캐시)에 캐싱되어 있는 각 SQL에 대한 수행 통계를 보여준다.
v$SQL은 쿼리가 수행을 마칠때마다 갱신되며, 오랫동안 수행되는 쿼리는 5초마다 갱신이 이루어 진다.

내용 출처: 친철한 SQL 튜닝(조시형저, 디비안) 551 ~ 552Page
*/

-- 주요 정보 리스트
-- 전체 컬럼 리스트는 하단에 첨부
SELECT 
		sql_id, child_number, sql_text, sql_fulltext, parsing_schema_name       -- 1
	,	loads, invalidations, parse_calls, executions, fetches, rows_processed  -- 2
	,	cpu_time, elapsed_time                                                  -- 3
	,	buffer_gets, disk_reads, sorts                                          -- 4
	,	first_load_time, last_active_time                                       -- 5
FROM V$SQL
ORDER BY first_load_time DESC;


-- 1. 라이브러리 캐시에 적재된 SQL 커서 자체에 대한 정보
-- 2. 하드파싱 및 무효화 발생횟수, Parse, Execute, Fetch Call 발생 횟수, Execute 또는 Fetch Call 시점에 처리한 로우 건수 등
-- 3. CPU 사용 시간과 DB 구간 소요시간(Microsecond)
-- 4. 논리적 블록 읽기와 디스크 읽기, 그리고 소트 발생 횟수
-- 5. 커서가 라이브러리 캐시에 처음 적재된 시점, 가장 마지막에 수행된 시점

-- V$SQL을 할용한 튜닝 필요 스키마 선정
-- IN절에 확인할 스키마명을 넣어서 사용할 수 있음
SELECT 
		parsing_schema_name
	,	count(*) AS "SQL개수"
	,	sum(executions) AS "수행횟수"
	,	round(avg(buffer_gets/executions)) AS "논리적I/O"
	,	round(avg(disk_reads/executions)) AS "물리적I/O"
	,	round(avg(rows_processed/executions)) AS "처리건수"
	,	round(avg(elapsed_time/executions/1000000), 2) AS "평균소요시간"
	,	count(CASE WHEN elapsed_time/executions/1000000 >= 10 THEN 1 end) AS "악성SQL"
	,	round(max(elapsed_time/executions/1000000), 2) AS "최대 소요시간"
FROM v$sql
WHERE parsing_schema_name IN ('DEV', 'SYS')                -- IN절에 확인할 스키마명을 넣어준다
AND last_active_time >= to_date('20220305', 'yyyymmdd')
AND executions > 0
GROUP BY parsing_schema_name;




-- V$SQL 뷰 전체 컬럼리스트 (oracle-19c 기준)
/*
SQL> desc v$sql;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SQL_TEXT                                           VARCHAR2(1000)
 SQL_FULLTEXT                                       CLOB
 SQL_ID                                             VARCHAR2(13)
 SHARABLE_MEM                                       NUMBER
 PERSISTENT_MEM                                     NUMBER
 RUNTIME_MEM                                        NUMBER
 SORTS                                              NUMBER
 LOADED_VERSIONS                                    NUMBER
 OPEN_VERSIONS                                      NUMBER
 USERS_OPENING                                      NUMBER
 FETCHES                                            NUMBER
 EXECUTIONS                                         NUMBER
 PX_SERVERS_EXECUTIONS                              NUMBER
 END_OF_FETCH_COUNT                                 NUMBER
 USERS_EXECUTING                                    NUMBER
 LOADS                                              NUMBER
 FIRST_LOAD_TIME                                    VARCHAR2(76)
 INVALIDATIONS                                      NUMBER
 PARSE_CALLS                                        NUMBER
 DISK_READS                                         NUMBER
 DIRECT_WRITES                                      NUMBER
 DIRECT_READS                                       NUMBER
 BUFFER_GETS                                        NUMBER
 APPLICATION_WAIT_TIME                              NUMBER
 CONCURRENCY_WAIT_TIME                              NUMBER
 CLUSTER_WAIT_TIME                                  NUMBER
 USER_IO_WAIT_TIME                                  NUMBER
 PLSQL_EXEC_TIME                                    NUMBER
 JAVA_EXEC_TIME                                     NUMBER
 ROWS_PROCESSED                                     NUMBER
 COMMAND_TYPE                                       NUMBER
 OPTIMIZER_MODE                                     VARCHAR2(10)
 OPTIMIZER_COST                                     NUMBER
 OPTIMIZER_ENV                                      RAW(2000)
 OPTIMIZER_ENV_HASH_VALUE                           NUMBER
 PARSING_USER_ID                                    NUMBER
 PARSING_SCHEMA_ID                                  NUMBER
 PARSING_SCHEMA_NAME                                VARCHAR2(128)
 KEPT_VERSIONS                                      NUMBER
 ADDRESS                                            RAW(8)
 TYPE_CHK_HEAP                                      RAW(8)
 HASH_VALUE                                         NUMBER
 OLD_HASH_VALUE                                     NUMBER
 PLAN_HASH_VALUE                                    NUMBER
 FULL_PLAN_HASH_VALUE                               NUMBER
 CHILD_NUMBER                                       NUMBER
 SERVICE                                            VARCHAR2(64)
 SERVICE_HASH                                       NUMBER
 MODULE                                             VARCHAR2(64)
 MODULE_HASH                                        NUMBER
 ACTION                                             VARCHAR2(64)
 ACTION_HASH                                        NUMBER
 SERIALIZABLE_ABORTS                                NUMBER
 OUTLINE_CATEGORY                                   VARCHAR2(64)
 CPU_TIME                                           NUMBER
 ELAPSED_TIME                                       NUMBER
 OUTLINE_SID                                        NUMBER
 CHILD_ADDRESS                                      RAW(8)
 SQLTYPE                                            NUMBER
 REMOTE                                             VARCHAR2(1)
 OBJECT_STATUS                                      VARCHAR2(19)
 LITERAL_HASH_VALUE                                 NUMBER
 LAST_LOAD_TIME                                     VARCHAR2(76)
 IS_OBSOLETE                                        VARCHAR2(1)
 IS_BIND_SENSITIVE                                  VARCHAR2(1)
 IS_BIND_AWARE                                      VARCHAR2(1)
 IS_SHAREABLE                                       VARCHAR2(1)
 CHILD_LATCH                                        NUMBER
 SQL_PROFILE                                        VARCHAR2(64)
 SQL_PATCH                                          VARCHAR2(128)
 SQL_PLAN_BASELINE                                  VARCHAR2(128)
 PROGRAM_ID                                         NUMBER
 PROGRAM_LINE#                                      NUMBER
 EXACT_MATCHING_SIGNATURE                           NUMBER
 FORCE_MATCHING_SIGNATURE                           NUMBER
 LAST_ACTIVE_TIME                                   DATE
 BIND_DATA                                          RAW(2000)
 TYPECHECK_MEM                                      NUMBER
 IO_CELL_OFFLOAD_ELIGIBLE_BYTES                     NUMBER
 IO_INTERCONNECT_BYTES                              NUMBER
 PHYSICAL_READ_REQUESTS                             NUMBER
 PHYSICAL_READ_BYTES                                NUMBER
 PHYSICAL_WRITE_REQUESTS                            NUMBER
 PHYSICAL_WRITE_BYTES                               NUMBER
 OPTIMIZED_PHY_READ_REQUESTS                        NUMBER
 LOCKED_TOTAL                                       NUMBER
 PINNED_TOTAL                                       NUMBER
 IO_CELL_UNCOMPRESSED_BYTES                         NUMBER
 IO_CELL_OFFLOAD_RETURNED_BYTES                     NUMBER
 CON_ID                                             NUMBER
 IS_REOPTIMIZABLE                                   VARCHAR2(1)
 IS_RESOLVED_ADAPTIVE_PLAN                          VARCHAR2(1)
 IM_SCANS                                           NUMBER
 IM_SCAN_BYTES_UNCOMPRESSED                         NUMBER
 IM_SCAN_BYTES_INMEMORY                             NUMBER
 DDL_NO_INVALIDATE                                  VARCHAR2(1)
 IS_ROLLING_INVALID                                 VARCHAR2(1)
 IS_ROLLING_REFRESH_INVALID                         VARCHAR2(1)
 RESULT_CACHE                                       VARCHAR2(1)
 SQL_QUARANTINE                                     VARCHAR2(128)
 AVOIDED_EXECUTIONS                                 NUMBER
 */