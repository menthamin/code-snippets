/* 샘플데이터 */

/* p235 일별 로그인 고객수 집계 */
SELECT 
	login_dt
	,	COUNT(DISTINCT user_id) AS user_cnt 
FROM login_log
GROUP BY
	login_dt
ORDER BY 
	login_dt;

/* p236 월별 등록 수 추이 */
-- TO_CHAR, SUBSTRING
-- GROUP BY
-- LAG(expr [,offset] [,default]) OVER([partition_by_clause] order_by_clause)
-- LEAD(expr [,offset] [,default]) OVER([partition_by_clause] order_by_clause)
-- LAG: 이전행의 값을 리턴 
-- LEAD: 다음행의 값을 리턴
-- expr: 대상컬럼명
-- offset: 값을 가져올 행의 위치 기본값은 1, 생략 가능
-- default: 값이 없을 경우 기본값, 생략  가능
-- partition_by_clause: 그룹 컬럼명, 생략 가능
-- order_by_clause: 정렬 컬럼명, 필수
-- 출처 : https://gent.tistory.com/339

WITH
user_with_year_month AS (
	SELECT 
		SUBSTRING(TO_CHAR(login_dt, 'YYYY-MM-DD HH24:MI:SS'), 1, 7) AS year_month
		, user_id
		, status
	FROM
		login_log
)
SELECT 
	year_month
	,	COUNT(DISTINCT user_id) AS register_count
	,	LAG(COUNT(DISTINCT user_id)) OVER(ORDER BY year_month) AS last_month_count
	,	1.0
		* COUNT(DISTINCT user_id)
		/ LAG(COUNT(DISTINCT user_id)) OVER(ORDER BY year_month) AS mom_ratio
FROM user_with_year_month
GROUP BY
	year_month;

/* 238p 등록 디바이스별 추이 */
-- 리포트 카테고리별 다운로드 현황으로 준비
SELECT * FROM report_download_log;

WITH
users_with_year_month AS (
	SELECT
			SUBSTRING(TO_CHAR(download_dt, 'YYYY-MM-DD HH24:MI:SS'), 1, 7) AS year_month
		,	ctgr
		,	file_nm
	FROM report_download_log
)
SELECT
		year_month
	,	COUNT(DISTINCT file_nm) AS tot_user_cnt
	, 	COUNT(DISTINCT CASE WHEN ctgr = '생활' THEN file_nm END) AS s_user_cnt
	, 	COUNT(DISTINCT CASE WHEN ctgr = '무형' THEN file_nm END) AS m_user_cnt 
	, 	COUNT(DISTINCT CASE WHEN ctgr = '패션' THEN file_nm END) AS p_user_cnt
FROM users_with_year_month
GROUP BY
		year_month
ORDER BY
		year_month;
