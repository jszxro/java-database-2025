/*
 * SQL - DML - SELECT 학습 
 */

-- 01. HR.employees 테이블의 모든 데이터를 조회하세요.
SELECT * -- asterik -> all로 받음. 모든 컬럼을 다 보여라.
	FROM employees;

-- 02. HR.employees중 employee_id, first_name, last_name, email, hire_date를 출력하라(107행)
SELECT employee_id, first_name, last_name, email, hire_date
	FROM employees;

-- 03. 02번의 쿼리를 컬럼명을 변경해서 출력하시오. '직원번호', '이름', '성', '이메일', '입사일자'로 변경하시오(107행)
SELECT employee_id AS "직원번호"
	 , first_name AS "이름"
	 , last_name AS "성"
	 , email AS "이메일"
	 , hire_date AS "입사일자"
	FROM employees;

-- 04. employees에서 job_id가 중복되지 않게 출력하시오.
SELECT DISTINCT job_id
	FROM employees;

SELECT COUNT(*) FROM employees;

-- 05. employees 테이블의 이름과 성을 붙여서 full_name으로, phone_number를 출력하시오.(107행)
SELECT first_name || ' ' || last_name AS "full_name"
	 , phone_number
	FROM employees;

-- 06. employees 테이블 직원들 정보를 아래와 같이 나오도록 출력하시오.(107행)
/*
 * full_name(employee_id) - job_id[hire_date] / phone_number
 */

SELECT first_name || ' ' || last_name || '(' || employee_id || ') - ' || job_id || '[' || hire_date || '] / ' || phone_number AS "total_info"
	FROM employees;

/*
 * 조건절 - WHERE 
 */

-- 연습. employees 테이블에서 employee_id가 110인 직원을 출력하세요.(1행)
SELECT *
	FROM employees
	WHERE employee_id = 110;

-- first_name이 John인 직원 출력.
SELECT *
	FROM employees
	WHERE first_name = 'John';

-- hire_date가 2006-02-12인 직원 출력.
SELECT *
	FROM employees 
	WHERE hire_date = '2006-02-12';

-- 데이터타입 숫자형, 문자형, 날짜형 등

/*
 * WHERE절에 사용하는 연산자
 * ● = : equal. 타 프로그래밍 언어와 달리 = 하나만 사용
 * ● !=, <> : not equal 같지 않다.
 * ● >, >=, <, <= : 크다, 크거나 같다, 작다, 작거나 같다
 * ● BETWEEN a AND b: 특정값이 a이상, b이하에 있다.
 * ● IN(a, b, c): 특정값이 a이거나 b이거나 c중 하나임
 * ● LIKE: SQL에서 문자열 비교에 특화된 연산자
 * ● IS NULL, IS NOT NULL: NULL 값을 검색할 때, NULL값이 아닌 걸 검색할 때
 * ● a AND b: a와 b 조건을 모두 만족해야 True
 * ● a OR b: a와 b 조건 둘 중 하나라도 만족하면 True
 * ● NOT a: a가 아닌 조건. 반대조건
 */

SELECT *
	FROM employees 
	WHERE hire_date != '2006-02-12';

-- between은 초과, 미만이 아니고 이상, 이하임.
SELECT *
	FROM employees 
	WHERE salary BETWEEN 9000 AND 15000;

SELECT *
	FROM employees 
	WHERE salary >= 9000 AND salary <= 15000;

SELECT *
	FROM employees 
	WHERE first_name IN ('John', 'Steven', 'Neena');

-- NULL 비교
SELECT * 
	FROM employees 
	WHERE commission_pct IS NULL;

SELECT * 
	FROM employees 
	WHERE commission_pct IS NOT NULL;

-- LIKE 문자열 패턴으로 검색
-- % 앞에 무슨 글자가 있든 상관없이
SELECT * 
	FROM employees 
	WHERE job_id LIKE '%MAN';

-- 뒤쪽 문자열은 상관없고 Ra로 시작하는 패턴을 가진 문자열을 찾아라
SELECT *
	FROM employees 
	WHERE last_name LIKE 'Ra%'; 

-- 총 글자수까지
SELECT *
	FROM employees 
	WHERE last_name LIKE 'Ra__'; 

-- 문자열 내 어디든지 MAN이 들어가는 문자를 찾아라
SELECT *
	FROM employees 
	WHERE job_id LIKE '%MAN%';

-- 07. employees에서 hire_date가 2005-01-01 이후에 입사했고, salary가 10000 이상인 직원을 출력.
SELECT first_name
	, last_name
	, phone_number
	, hire_date
	, salary
	FROM employees
	WHERE hire_date > '2005-01-01'
	AND salary >= 10000;

/*
 * 정렬 - ORDER BY
 * ASCending
 * DESCending 
 */

SELECT *
	FROM employees 
	ORDER BY salary ASC;

SELECT *
	FROM employees 
	ORDER BY job_id ASC, salary DESC;

/*
 * 집합, UNION, UNION ALL, INTERSECT, MINUS
 */

-- SELECT * FROM DEPARTMENTS d
-- departments에서 department_id가 50 이하인 부서 아이디와 부서명 데이터
-- employees에서 employee_id가 110에 150 사이인 직원아이디와 직원명(first_name || last_name)를 합쳐서 출력하시오.	
SELECT department_id, department_name
	FROM departments 
	WHERE department_id <= 50;

SELECT employee_id, first_name || last_name AS "full_name"
	FROM employees 
	WHERE employee_id BETWEEN 110 AND 150;