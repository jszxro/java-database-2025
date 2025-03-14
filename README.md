# java-database-2025
PK_Java 개발 과정

## 1일차
- Github Desktop 설치
    - Git 명령어 없이 사용 가능

- Database(DB) 개요
    - 데이터를 저장 및 관리
    - 데이터베이스를 관리
    - 가장 유명한 것이 Oracle
    - 사용자는 SQL로 요청

- Oracle 설치(Docker)
    1. Powershell 오픈
    2. pull 내려받기
        ```shell
        > docker pull oracleinanutshell/oracle-xe-11g
        ```
    3. 다운로드 이미지 확인
        ```shell
        PS C:\Users\jszxr> docker image ls
        ```
    4. 도커 컨테이너 실행
        ```shell
        > docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1522: Oracle 기본 port(항구)
    5. 도커 실행 확인
        - Docker Desktop > Containers 확인
    6. Powershell 오픈
        ```shell
        > docker exec -it oracle19c bash
        [oracle@94b01e97c7c1 ~]$ sqlplus / as sysdba

        SQL > 
        ```
    7. DBeaver 접속
        - Connection > Select your DB > Oracle 선택

        <img src="./image/db001.png" width="650">

-DBeaver 툴 설치

- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
    - SQL - 무엇(What)
        - 프로그래밍 언어와 차이 - 어떻게(How)
    - SQL의 구성요소 3가지
        1. DDL(Data Definition Lang)
            - 데이터베이스 생성, 테이블 생성, 객체 생성, 수정, 삭제
                - CREATE, ALTER, DROP...
        2. DCL(Data Control Lang)
            - 사용자 권한 부여, 해제, 트랜잭션 시작, 종료
                - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
        3. DML(Data Manupulation Lang) 
            - 데이터 조작 언어(핵심), 데이터 삽입, 조회, 수정, 삭제
                - INSERT, SELECT, UPDATE, DELETE


- SELECT 기본
    - 데이터 조회 시 사용하는 기본명령어
    ```sql
    -- 기본 주석(한 줄)
    /*
        여러줄 주석
    */
    SELECT [ALL|DISTINCT][*|컬럼명(들)]
        FROM 테이블명(들)
    [WHERE 검색조건(들)]
    [GROUP BY 속성명(들)]
    [HAVING 집계함수조건(들)]
    [ORDER BY 정렬속성(들) ASC|DESC]
    [WITH ROLLUP]
    ```
    - 기본 쿼리 학습: [SQL](./day01/sql01_select기본.sql)
        1. 기본 SELECT
        2. WHERE 조건절
        3. NULL(!)
        4. ORDER BY 정렬
        5. 집합

- 함수(내장함수)
    - 문자함수: [SQL](./day01/sql02_함수.sql)

## 2일차

- 함수(계속)
    - 문자함수부터:
    - 숫자함수
    - 날짜함수
    - 형변환함수

- 데이터베이스 타입형
    - **CHAR(n)** - 고정형 문자열, 최대 2000바이트
        - 'Hello World', 공백 포함
    - **VARCHAR(n)** - 가변형 문자열, 최대 4000qkdlxm
        - 'Hello World'
    - INTEGER - 모든 데이터의 기준. 4byte, 정수를 담는 데이터형
    - FLOAT(p) - 실수형 타입, 최대 22byte
    - NUMBER(p, s) - 숫자값, p 전체 자리수, s 소수점 길이. 최대 22byte
    - Date - 날짜 타입
    - LONG(n) - 가변 길이 문자열, 최대 2G바이트
    - LONG(n) - 원시 이진 데이터, 최대 2G바이트
    - CLOB - 대용량 텍스트 데이터 타입, 최대 4G
    - BLOB - 대용량 바이너리 데이터 타입, 최대 4G
    - BFILE - 외부 파일에 저장된 데이터터
