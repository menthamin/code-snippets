/* 251p 정착률 관련 리포트 */
-- 매일의 n일 정착률 추이

WITH
repeat_interval(index_name, interval_begin_date, interval_end_date) AS (
	VALUES
		('07 day retention', 1, 7)
	,	('14 day retention', 8, 14)
	,	('21 day retention', 15, 21)
	,	('28 day retention', 22, 28)
)
, download_log_with_index_date AS (
	SELECT 
			mu.user_id
		,	mu.register_date
		-- 다운로드 날짜와 로그 전체의 최신 날짜를 날짜 자료형으로 변환
		,	CAST(rdl.download_dt AS DATE) AS download_date
		,	MAX(CAST(rdl.download_dt AS DATE)) OVER() AS latest_date
		-- 지표의 대상 기간 시작일과 종료일 계산하기
		, 	r.index_name
		,	(mu.register_date + r.interval_begin_date) AS index_begin_date
		,	(mu.register_date + r.interval_end_date) AS index_end_date
	FROM
		MST_USERS AS mu
	LEFT OUTER JOIN
		REPORT_DOWNLOAD_LOG AS rdl
	ON mu.user_id = rdl.user_id
	CROSS JOIN 
		repeat_interval AS r  -- 핵심
	WHERE rdl.download_dt <= '2020-07-01'
)
, user_download_flag AS (
	SELECT
			user_id
		,	register_date
		,	index_name
			-- 4. 등록일 다음날에 액션을 했는지 안 했는지를 플래그로 나타내기
		,	SIGN(
			-- 3. 사용자별로 등록일 다음날에 한 액션의 합계 구하기
				SUM(
				-- 1. 등록일 다음날이 로그의 최신 날짜 이전인지 확인하기 -- log 안쌓였을 경우 대비
				CASE WHEN index_end_date <= latest_date THEN
					-- 2. 등록일 다음날의 날짜에 액션을 했다면 1, 안 했다면 0 지정하기
					CASE WHEN download_date BETWEEN index_begin_date AND index_end_date 
						THEN 1 ELSE 0 
					END
				END
				)
		) AS index_date_download
	FROM download_log_with_index_date
	GROUP BY
		user_id, register_date, index_name
)
SELECT 
			register_date
		,	index_name
		, 	AVG(100.0 * index_date_download) AS index_rate
FROM user_download_flag
GROUP BY
	register_date, index_name
ORDER BY
	register_date, index_name;
