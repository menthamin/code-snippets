/* Postgresql 뷰 리스트 조회하기 
 * 
 * 목적: Postgresql 관리를 위한 뷰 리스트 확인
 * 출처: https://dataedo.com/kb/query/postgresql/list-views-in-a-database
 * 
 */
select table_schema as schema_name,
       table_name as view_name
from information_schema.views;

-- 테이블 정보 확인하는 뷰
-- 뷰이름: PG_CATALOG.pg_stat_user_tables
-- 여러 조건으로 order by 진행
SELECT * FROM PG_CATALOG.pg_stat_user_tables
ORDER BY n_tup_del DESC;

SELECT * FROM PG_CATALOG.pg_stat_user_tables
ORDER BY n_dead_tup DESC;

SELECT * FROM PG_CATALOG.pg_stat_user_tables
ORDER BY n_live_tup DESC;

SELECT * FROM PG_CATALOG.pg_stat_user_tables
ORDER BY seq_scan DESC;

-- SELECT * FROM PG_CATALOG.pg_stat_activity;