/*
 * PL/SQL 
 */

-- SET SERVEROUTPUT ON; 콘솔에서만 사용
DECLARE -- 선언부, 여기에 사용할 모든 변수를 선언해야 함
	v_empno		 emp.empno%TYPE; -- number(4,0);를 대체해서 특정 테이블의 컬럼과 같은 데이터 타입을 쓰겠다고 선언
	v_ename		 varchar2(10);
BEGIN -- PL/SQL은 시작과 끝을 지정해야 함
	SELECT empno, ename INTO v_empno, v_ename
	FROM emp
	WHERE empno = :empno;

	DBMS_OUTPUT.PUT_LINE(v_empno || '- 이 멤버의 이름은  ' || v_ename);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('멤버가 없음');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('데이터가 많음');
END;
/
COMMIT;