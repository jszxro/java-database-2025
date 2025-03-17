-- HR 계정 잠금 해제

ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY 12345;

ALTER USER scott ACCOUNT UNLOCK;

SELECT username FROM dba_users WHERE username = 'SCOTT';

SELECT * FROM jobs;

CREATE VIEW JOBS_VIEW
AS
	SELECT *
	 FROM jobs;

SELECT *
	FROM USER_TAB_PRIVS;

CREATE TABLE test (
	id NUMBER PRIMARY KEY,
	name varchar(20) NOT NULL 
);

-- 사용자 역할(Role) 관리
-- 역할(role)이란 여러 사용자에게 특정 권한을 부여하기 위한 개념

-- 역할(Role) 확인
-- CONNECT : 데이터베이스 접속 및 테이블 생성 권한
-- RESOURCE : PL/SQL 사용 권한
-- DBA : 모든 시스템 관리 권한
-- EXP_FULL_DATABASE : DB 내보내기(Export) 권한

-- 현재 사용자의 역할(Role) 조회

SELECT * FROM user_role_privs;

-- HR에게 DBA역할 role 부여

GRANT DBA TO hr;

REVOKE DBA FROM hr;

COMMIT;