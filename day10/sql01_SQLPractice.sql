/*
 * 기본 SELECT문
*/

-- ex1) Employees 테이블에서 사원번호, 이름(이름, 성 합쳐서 표시), 급여, 업무, 입사일, 상사의 사원번호로 출력하시오(107행)
SELECT EMPLOYEE_ID
	 , first_name || ' ' ||last_name AS full_name
	 , salary
	 , job_id
	 , to_char(hire_date, 'yyyy-mm-dd') AS hire_date
	 , manager_id
	FROM employees;

-- ex2) Employees 테이블에서 모든 사원의 이름(last_name)과 연봉을 '이름: 1 year salary = $연봉' 형식으로 출력하고, 컬럼명을 1 Year Salary로 변경(107행)
SELECT LAST_NAME || ': 1 year salary =' || to_char(salary * 12, '$999,999.99') AS "1 Year Salary"
	FROM EMPLOYEES;

-- ex3) 부서별로 담당하는 업무를 한 번씩만 출력하시오(20행)
SELECT DISTINCT DEPARTMENT_ID, JOB_ID 
	FROM employees;

/*
 * WHERE절, ORDER BY절
*/

-- ex4) Employees 테이블에서 급여가 7,000 ~ 10,000달러 범위이외 사람의 이름과 성을 full_name, 급여를 오름차순으로 출력하시오(75행)
SELECT first_name || ' ' || last_name AS full_name
 	 , salary
	FROM EMPLOYEES
   WHERE salary < 7000 
      OR salary > 10000
ORDER BY salary ASC;

SELECT *
	FROM EMPLOYEES
   WHERE salary NOT BETWEEN 7000 AND 10000
ORDER BY salary ASC;

-- ex5) 현재 날짜 타입을 날짜 함수를 통해서 확인하고, 입사일자가 2003년 5월 20일부터 2004년 5월 20일 사이에 입사한 사원의 이름, 사원번호, 고용일자 출력하시오(10행)
SELECT SYSDATE FROM DUAL;

SELECT first_name || ' ' || last_name AS full_name
	 , EMPLOYEE_ID
	 , tO_char(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE
	FROM EMPLOYEES
	WHERE HIRE_DATE BETWEEN '2003-05-20' AND '2004-05-20';

/*
 * 단일행 함수와 변환 함수
*/

-- ex6) IT부서 사원 급여를 15.3% 인상, 정수만 반올림, 출력 형식은 사번, 이름과 성, 급여, 인상된 급여(Increased Salary) 출력(5행)
SELECT EMPLOYEE_ID
	 , first_name || ' ' || last_name AS full_name
	 , salary
	 , round(salary * 1.153) AS "Increased Salary"
	FROM employees
	WHERE job_id = 'IT_PROG';

-- ex7) 모든 사원의 연봉을 표시하는 보고서 작성, full_name, 급여, 수당 여부에 따라 연봉을 표시하시오(107행), 수당이 있으면 salart + commision
SELECT first_name || ' ' || last_name AS full_name
	 , salary
	 , (salary * 12) + (salary * nvl(commission_pct, 0)) AS "Annual Salary"
	 , CASE WHEN commission_pct IS NULL THEN  'salary only'
	 		WHEN commission_pct IS NOT NULL THEN 'salary + commssion'
	 		END AS "Commission?"
	FROM employees
	ORDER BY 3 DESC;

/*
 * 집계 함수, MIN, MAX, SUM, AVG, COUNT...
 * GROUP BY와 같이 사용
*/

-- ex8) employees에서 각 사원이 소속된 부서별, 급여 합계, 급여 평균, 급여 최대값, 급여 최소값 집계
SELECT department_id
	 , to_char(sum(salary), '$999,999') AS "Sum Salary"
	 , to_char(avg(salary), '$99,999.9') AS "Avg Salary"
	 , to_char(max(salary), '$999,999') AS "Max Salary"
	 , to_char(min(salary), '$999,999') AS "Min Salary"
	FROM employees
	WHERE department_id IS NOT NULL 
	GROUP BY department_id
	ORDER BY department_id ASC;

/*
 * Join
*/

-- ex9) employees, department, locations 테이블 구조 파악
--		Oxford에 근무하는 사원 full_name, 업무, 부서명, 도시명을 출력하시오(34행) 
SELECT e.first_name || ' ' || e.last_name AS full_name
	 , e.job_id
	 , d.department_name
	 , l.city
	FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
	WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.city = 'Oxford'
	
COMMIT;

-- ex10) 부서가 없는 직원까지 모두 full_name, 업무, 부서명을 출력하시오(107행)
-- 		 LEFT OUTER JOIN 
SELECT e.first_name || ' ' || e.last_name AS full_name
	 , e.job_id
	 , d.department_name
	FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
	WHERE e.department_id = d.department_id(+);

/*
 * 서브 쿼리
*/

-- ex11) Tucker 사원보다 급여를 많이 받는 사원의 full_name,업무, 급여를 출력(15행)
SELECT salary
	FROM employees
	WHERE last_name = 'Tucker';

SELECT first_name || ' ' || last_name AS full_name
	 , job_id
	 , salary
	FROM employees
	WHERE salary > (SELECT salary
						FROM employees
						WHERE last_name = 'Tucker');

-- ex12) 부서와 업무별 급여 합계를 구하여서 급여 수준 레벨을 지정하고자 함
--		 부서별, 업무별 급여 합계 및 각 부서별 총합, 각 부서별, 업무별 직원수를 출력하시오

SELECT department_id, job_id
 	 , to_char(sum(salary), '$99,999') AS "Sum Salary"
 	 , count(*) AS "Employee Cnt"
	FROM EMPLOYEES
	GROUP BY ROLLUP(department_id, job_id);

COMMIT;

SELECT d.NAMES AS 장르, SUM(b.PRICE) AS 총대여금액
FROM RENTALTBL r
JOIN BOOKTBL b ON r.BOOKIDX = b.IDX
JOIN DIVTBL d ON b.DIVISION = d.DIVISION
GROUP BY d.NAMES
ORDER BY 총대여금액 DESC;