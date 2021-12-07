/* 
    참고자료 : 데이터 분석을 위한 SQL 레시피 55 ~ 57 page 
    작업환경 : PostgreSQL
*/

DROP TABLE IF EXISTS access_log ;
CREATE TABLE access_log (
    stamp    varchar(255)
  , referrer text
  , url      text
);

INSERT INTO access_log 
VALUES
    ('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001')
  , ('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref'          )
  , ('2016-08-26 12:02:01', 'https://www.other.com/'                               , 'http://www.example.com/book/detail?id=002' )
;

SELECT * FROM access_log;

/* URL에서 레퍼러 추출하기 */
SELECT
	stamp
,	substring(referrer from 'https?://([^/]*)') as referrer_host
-- 해석 ? = 앞에 문자가 있을수도 없을 수도 있다. ex) https?:// → https://, http:// 2개 케이스 매칭
-- * = 0개 이상, + = 1개 이상 
, 	referrer
FROM example.access_log;

/* URL에서 path와 요청 매개변수값 출력하기 */
SELECT
	stamp
,	url
, 	referrer
,	substring(url from '//[^/]+([^?#]+)') as path
,	substring(url from 'id=([^&]*)') as id
,	substring(referrer from '[?]+([^#]*)') as parameters
FROm example.access_log;