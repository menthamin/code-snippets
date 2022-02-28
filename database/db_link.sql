-- DB 링크 생성 예시

select * from sys.dba_users;

SELECT * FROM user_sys_privs
WHERE username = 'ADMIN';

SELECT * FROM user_role_privs
WHERE username = 'ADMIN';

GRANT CREATE SESSION TO RDSADMIN WITH ADMIN OPTION;
GRANT ALTER SESSION TO RDSADMIN WITH ADMIN OPTION;
GRANT CREATE PUBLIC DATABASE link TO RDSADMIN WITH ADMIN OPTION;
GRANT CONNECT, resource, dba TO RDSADMIN;
GRANT ADMINISTER DATABASE TRIGGER TO RDSADMIN;
GRANT create view, create session, create table, create procedure TO RDSADMIN WITH ADMIN OPTION;

SELECT * FROM sys.dba_role_privs
WHERE grantee = 'RDSADMIN';
--WHERE granted_role = 'RDS_MASTER_ROLE';

CREATE PUBLIC DATABASE LINK sample
CONNECT TO system IDENTIFIED BY "gkgkgh12"
USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=218.209.104.161)(PORT=1614)) (CONNECT_DATA=(SERVICE_NAME=xe)))';

-- DROP DATABASE LINK sample;


SELECT * FROM dba_db_links;
SELECT * FROM hreport.user_map@sample;

-- 시노임 조회 및 생성 
SELECT * FROM all_synonyms;

CREATE synonym user_map FOR hreport.user_map@sample;

SELECT * FROM user_map;
SELECT * FROM all_synonyms
WHERE db_link IS NOT NULL;

SELECT * FROM all_synonyms
WHERE table_name = 'USER_MAP';

DROP synonym user_map;