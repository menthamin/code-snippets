/* Oracle 누적 Distinct 유저 카운트 예제 쿼리
 * 참고자료: https://stackoverflow.com/questions/37679478/counting-distinct-users-over-time
 */
--DROP TABLE login_info_sample;

CREATE TABLE login_info_sample (	
		user_id VARCHAR2(10)
	,	login_dt DATE 
);

INSERT INTO login_info_sample (user_id, login_dt) VALUES('1001', '2022-01-01');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1002', '2022-01-01');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1003', '2022-01-01');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1004', '2022-01-01');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1005', '2022-01-01');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1001', '2022-01-02');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1002', '2022-01-02');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1003', '2022-01-02');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1006', '2022-01-02');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1007', '2022-01-02');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1004', '2022-01-03');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1005', '2022-01-03');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1006', '2022-01-03');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1008', '2022-01-03');
INSERT INTO login_info_sample (user_id, login_dt) VALUES('1009', '2022-01-03');

SELECT * FROM login_info_sample;

WITH
login_info_seq AS (
-- ROW_NUMER() 활용 User별 로그인 순서 채번
-- Partiton by user_id / Order by login_dt 
SELECT 
		t.*
	,	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_dt) AS seq_num
FROM login_info_sample t
)
SELECT
		to_char(login_dt, 'yyyy-mm-dd') AS login_dt
	,	SUM(SUM(CASE WHEN seq_num = 1 THEN 1 ELSE 0 END)) OVER (ORDER BY login_dt) AS cum_user_cnt
FROM login_info_seq
GROUP BY login_dt
ORDER BY 1;
