/*
 * 복수행, GROUP BY와 가장 많이 사용
 * COUNT(), SUM(), AVG(), MIN/MAX(), STDDEV(), ... 
 * ROLLUP, CUBE, RANK, DENSE_RANK...
 */

SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') FROM dual;
ALTER SESSION SET CURRENT_SCHEMA = HR;

-- COUNT() 많이 씀
SELECT count(*) -- scalar value
	FROM employees;

-- SUM(숫자형 컬럼) 합계
-- employees 206 salary 8300 삭제
SELECT sum(salary)
	FROM employees;

-- AVG(숫자형 컬럼) 평균
-- 컬럼에 NULL 값이 있으면 제외하고 계산하기 때문에 잘못된 값이 도출
-- 금액이나 수량을 계산하는 컬럼의 NULL 값은 전처리 해줘야 함.
SELECT avg(salary)
	FROM employees;

SELECT count(salary)
	FROM employees;

-- MIN(숫자형 컬럼|문자형도 가능), MAX()
SELECT max(salary)
	 , min(salary)
	FROM employees;

/*
 * GROUP BY 연계 
 * GROUP BY를 사용하면 SELECT절에는 GROUP BY 사용한 컬럼과 집계 함수 및 일반 함수만 사용할 수 있음
 */

SELECT department_id
	 , avg(salary) AS 부서별평균급여
	 , to_char(round(avg(salary), 1), '99,999.9') AS 부서별평균급여
	FROM employees
	GROUP BY department_id;

-- 집계함수는 WHERE절에 사용 불가
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
	FROM employees
	WHERE department_id BETWEEN 30 AND 90
	GROUP BY department_id, job_id
	HAVING sum(salary) >= 20000
	ORDER BY department_id;

-- ORDER BY에는 컬럼의 순번(1부터 시작)으로 컬럼명을 대체 가능
SELECT department_id, job_id, sum(salary) AS 부서직군별급여총액
	 , count(*)
	FROM employees
	WHERE department_id BETWEEN 30 AND 90
	GROUP BY department_id, job_id
	HAVING sum(salary) >= 20000
	ORDER BY 3 DESC;

-- PIVOT() 엑셀과 동일한 기능
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*)
	FROM employees;

-- 옆으로 각 달별로 스프레드
SELECT CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "1월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "2월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "3월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "4월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "5월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "6월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "7월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "8월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "9월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "10월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "11월"
	 , CASE to_char(hire_date, 'MM') WHEN '01' THEN count(*) ELSE 0 END AS "12월"
	 FROM employees
	 GROUP BY to_char(hire_date, 'MM')
	 ORDER BY to_char(hire_Date, 'MM');

-- decode
SELECT decode(to_char(hire_date, 'MM'), '01', count(*), 0) AS "1월"
	 , decode(to_char(hire_date, 'MM'), '02', count(*), 0) AS "2월"
	 , decode(to_char(hire_date, 'MM'), '03', count(*), 0) AS "3월"
	 , decode(to_char(hire_date, 'MM'), '04', count(*), 0) AS "4월"
	 , decode(to_char(hire_date, 'MM'), '05', count(*), 0) AS "5월"
	 , decode(to_char(hire_date, 'MM'), '06', count(*), 0) AS "6월"
	 , decode(to_char(hire_date, 'MM'), '07', count(*), 0) AS "7월"
	 , decode(to_char(hire_date, 'MM'), '08', count(*), 0) AS "8월"
	 , decode(to_char(hire_date, 'MM'), '09', count(*), 0) AS "9월"
	 , decode(to_char(hire_date, 'MM'), '10', count(*), 0) AS "10월"
	 , decode(to_char(hire_date, 'MM'), '11', count(*), 0) AS "11월"
	 , decode(to_char(hire_date, 'MM'), '12', count(*), 0) AS "12월"
	 FROM employees
	 GROUP BY to_char(hire_date, 'MM')
	 ORDER BY to_char(hire_Date, 'MM');
	 

