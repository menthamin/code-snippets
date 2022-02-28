/* 오라클 View 확인 하기 
 * 
 * 목적: Oracle 관리를 위한 주요 뷰 확인
 * 
 */

SELECT * FROM dba_extents;

SELECT * FROM dba_segments;

-- 대기이벤트 관련 뷰
SELECT * FROM v$event_name;
SELECT * FROM v$system_event;
SELECT * FROM v$session_event;
SELECT * FROM v$session_wait;

SELECT count(*) FROM v$system_event;
SELECT * FROM v$system_event
WHERE event LIKE '%enq%'

SELECT * FROM v$event_name
WHERE name LIKE '%buffer%';


-- 의도적으로 늘려보겠다.
SELECT * FROM v$system_event
WHERE event_id = '2161531084';

--
SELECT * FROM v$system_event
WHERE event = 'read by other session';

SELECT * FROM SBSCB_INFO SI
WHERE user_id = 'user1';


SELECT * FROM v$session_event
ORDER BY total_waits DESC;

SELECT * FROM v$memory_dynamic_components;
-- 출처: https://clipper0317.tistory.com/1 [오라클의 세계]

select * from v$memory_target_advice order by memory_size;
-- 출처: https://clipper0317.tistory.com/1 [오라클의 세계]

select * from v$sgainfo;
-- 출처: https://leejehong.tistory.com/entry/SGA-PGA-%EC%84%A4%EC%A0%95-%ED%99%95%EC%9D%B8-%EB%B0%8F-%EB%B3%80%EA%B2%BD

select * from v$sga;
-- Oracle 모든 View 조회
SELECT * FROM ALL_OBJECTS
WHERE object_name LIKE 'V$%';

-- Oracle 모든 View 조회
SELECT count(*) FROM ALL_OBJECTS
WHERE object_name LIKE 'V$%'

SELECT count(*) as cnt FROM 
(SELECT rownum AS rn, vl.* FROM v$latch_misses vl)
WHERE rn > 7000;

-- 
SELECT * FROM V$WAITCLASSMETRIC_HISTORY;
SELECT * FROM V$MAP_FILE_EXTENT;
SELECT * FROM V$MAP_LIBRARY;
SELECT * FROM V$SQL_PLAN;
SELECT * FROM V$SQL_PLAN_STATISTICS;
SELECT * FROM V$SQL_PLAN_STATISTICS_ALL;

-- 플랜 조회 
SELECT count(*) FROM V$SQL_PLAN;

SELECT * FROM DASH_DOWNLOAD_MST
WHERE user_id = '1002';

SELECT count(*) FROM V$SQL_PLAN;


SELECT * FROM V$SQL_PLAN;

SELECT * FROM DASH_DOWNLOAD_MST
WHERE user_id = to_char(:input_user_id);

SELECT * FROM V$SQL_PLAN_STATISTICS_ALL
WHERE object_name = 'DASH_DOWNLOAD_MST'
ORDER BY timestamp DESC;

-- 라이브러리 캐시조회
SELECT * FROM V$LIBRARYCACHE;

SELECT * FROM DASH_DOWNLOAD_MST
WHERE user_id = '1133';

-- 튜닝대상 뽑기좋은
-- sql DW라고 생각하자
SELECT * FROM v$sql;