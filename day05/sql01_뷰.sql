/*
 * VIEW
 * */
-- sysdba로 실행햐애 됨(sampleuser에서 만들 수 있는 권한 부여)
GRANT CREATE VIEW TO sampleuser;

--
SELECT * FROM emp2;

-- 뷰 생성 DDL(sysbda에서 권한 부여 안받으면 권한 없다고 안됨-에러뜸)
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, depto, tel, POSITION, pempno -- DEPTNO 컬럼 넣었다가 2번 INSERT 할 때뺌
	  FROM emp2;

-- 뷰로 select 조회
SELECT *
  FROM v_emp2;

-- 뷰로 insert하기
-- 단, 뷰에 속하지 않는 컬럼중 NOT NULL 조건이 있으면 데이터 삽입 불가
-- 테이블 조회해보면 체크 여부 확인 가능
INSERT INTO v_emp2 VALUES(20000219, 'Tom Halland', 1004, '051)627-9968', 'IT Programmer', 19960303); -- 얘는 뷰 생성에서 DEPTNO 삭제 전에 만든 애

-- 뷰 생성2
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, tel, POSITION, pempno -- DEPTNO 컬럼 넣었다가 2번 INSERT 할 때뺌
	  FROM emp2;

-- deptno 컬럼이 NOT NULL인데 뷰에는 존재하지 않아 INSERT 불가
INSERT INTO v_emp2 VALUES(20000219, 'Zen Daiya', '051)627-9968', 'IT Programmer', 19960303); -- 오류남

COMMIT; -- 커밋해줘야 들어가있음

-- CRUD 중 SELECT만 가능하게 만들려면
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM emp2
WITH READ ONLY;

-- 삽입 불가
INSERT INTO v_emp2 VALUES(20000221,'Hugo Sung', 1004, '051)627-9768', 'IT Programmer', 19960303);

-- 복합뷰 : 조인등으로 여러 테이블을 합쳐서 보여주는 뷰
-- 복합뷰는 INSERT, UPDATE, DELETE가 거의 불가
CREATE OR REPLACE VIEW V_emp3
AS
	SELECT e.empno, e.name, e.DEPTNO , d.dname -- SELECT * 로 먼저 어떤 컬림이 필요한지 찾아보고 위에꺼 사용하기
	  FROM emp2 e, dept2 d
	 WHERE e.deptno = d.dcode;

-- 조회
SELECT * FROM V_emp3;
