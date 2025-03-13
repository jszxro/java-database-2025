/*
 * JOIN 
 */

-- 개념
-- 정규화되어 나누어진 테이블의 데이터를 한꺼번에 모아서 쉽게 출력하기 위한 기법
SELECT *
	FROM employees e, departments d
   WHERE e.department_id = d.department_id;

-- 총 데이터 수: 2889

SELECT *
	FROM departments
   WHERE department_id = 100;

-- 오라클 방식 표준 X, 
SELECT *
	FROM employees e, departments d
   WHERE e.department_id = d.department_id;

-- ANSI 표준 문법
SELECT * 
	FROM employees e
	LEFT OUTER JOIN departments d
	ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- Oracle 문법
-- (+)만족하지 않는 조건도 더 나오게 한다는 뜻
-- LEFT OUTER JOIN
SELECT * 
	FROM employees e, departments d
	WHERE e.department_id = d.department_id(+);

-- RIFGT OUTER JOIN
SELECT * 
	FROM employees e, departments d
	WHERE e.department_id(+) = d.department_id;

-- INNER JOIN은 INNER를 생략 가능
-- OUTER JOIN에만 LEFT와 RIGHT가 존재하므로 생략 가능

-- 셀프조인: 자기 자신을 두 번 사용하는 조인
SELECT e1.EMPLOYEE_ID 
	 , e1.first_name || ' ' || e1.last_name AS "full_emp_name"
	 , e1.job_id
	 , e1.MANAGER_ID
	 , e2.first_name || ' ' || e2.last_name AS "full_mng_name"
	 , e2.JOB_ID
	FROM employees e1, employees e2
	WHERE e1.employee_id = e2.manager_id(+)
	ORDER BY e1.manager_id;




