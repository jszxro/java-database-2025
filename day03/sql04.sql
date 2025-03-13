/*
 * DDL - 데이터 조작 언어
 * CREATE, ALTER, DROP, TRUNCATE...
 * 객체를 생성하고, 수정하고, 삭제하거나, 데이터를 초기화...
 */

-- no, name, birth 컬럼의 테이블 new_table 생성.
CREATE TABLE new_table(
	NO NUMBER(5,0) PRIMARY KEY -- PK는 지정하는 게 기본
);

DROP TABLE new_table;

CREATE TABLE new_table(
	NO NUMBER(5,0) PRIMARY KEY, -- PK는 지정하는 게 기본
	NAME varchar2(20) NOT NULL,
	JUMIN char(14),
	BIRTH DATE,
	SALARY number(7,0) DEFAULT 0
);

SELECT TABLE_NAME 
FROM USER_TABLES
WHERE TABLE_NAME = 'NEW_TABLE';

SELECT OWNER, TABLE_NAME 
FROM ALL_TABLES
WHERE TABLE_NAME = 'NEW_TABLE';

-- 기본키가 두 개인 테이블 생성

CREATE TABLE DOUBLEKEYTBL(
	ID NUMBER(5,0),
	CODE CHAR(4),
	NAME VARDHAR(20) NOT NULL,
	JUMIN CHAR(14) UNIQUE,
	CONSTRAINT PK_DOUBLEKEYTBL PRIMARY KEY(ID, CODE)
);

-- new_member 부모 테이블과 new_board 자식 테이블 간의 관계가 성립된 테이블을 생성하시오.
CREATE TABLE new_member(
	idx NUMBER PRIMARY KEY,
	name varchar2(20) NOT NULL,
	id varchar2(20) NOT NULL,
	pass varchar2(256)
);

CREATE TABLE new_board(
	bibx NUMBER PRIMARY KEY,
	title varchar2(125) NOT NULL,
	content LONG NOT NULL,
	reg_date DATE DEFAULT sysdate,
	count number(6, 0) DEFAULT,
	midx NUMBER NOT NULL,
	CONSTRAINT FK_memberidx FOREIGN KEY (midx) REFERENCES new_member (idx) 
);

-- ALTER 기존 테이블을 수정할 때 사용
-- 이미 데이터가 존재하는 테이블에 NOT NULL 컬럼은 추가 불가능
ALTER TABLE new_table ADD (address varchar2(200));

-- 컬럼 수정
ALTER TABLE new_table modify (address varchar2(100));

-- DROP 테이블 삭제
-- purge 휴지통으로 보냄





















