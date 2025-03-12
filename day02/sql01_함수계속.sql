/*단일행 함수*/
SELECT concat('hello','oracle') --  한 행에 한 열만 출력되는 값 : 스칼라(Scalar)값
FROM dual; -- 가상의 테이블

-- 인덱스가 1부터, 일반 프로그래밍 언어의 배열이 0부터 시작하는 것과의 차이
-- SUBSRT() - 파이썬 Substring() 함수와 동일
-- 인덱스 뒤에서부터 위치
SELECT substr(email, 1,2)
    , substr(email, -2,2)
    , email
from Employees; 

-- 전화번호 자를 때, 주민번호 자를 때, substr() 활용

-- INSTR(체크할 문자열, 찾는 글자, 시작 위치, 몇번째)
SELECT '010-9999-8888', instr('010-9999-8888', '-',1,1)
FROM dual;

--LPAD(문자열, 자리수, 채울 문자)
-- 2025-11-23
-- 2025-3-12 -> 2025-03-12
--0000100 이 규칙일 때, 101->0000101으로 만들때 사용
SELECT LPAD('100',7,'0'), RPAD('ABC',7,'-')
FROM dual;

--TRIM() 함수 트리플. 파이썬 strip() 함수와 동일
--LTRIM(), RTRIM(), TRIM()
SELECT '<<<' || '     hello oracle     ' || '>>>',
      '<<<' || ltrim('     hello oracle     ') || '>>>',
      '<<<' || rtrim('     hello oracle     ') || '>>>',
      '<<<' || trim('     hello oracle     ') || '>>>'
FROM dual;

-- replace(), 파이썬과 동일
SELECT phone_number
    , replace(EMPLOYEES.PHONE_NUMBER ,'123','786')
FROM employees;

/*숫자함수*/
-- round() : 반올림
-- ceil() : 올림
-- floor() : 내림
-- trunc() : 내림함수 소수점 o
-- mod() : 나누기 나머지값, 파이썬 mode, %
-- power() 파이썬 math.pow(), pow(), power(), 2^10 승수 계산
SELECT 786.5427 AS res1
            , round(786.5427) AS round0 -- 소수점 x
            , round(786.5427,1) AS round1 -- 소수점 1
            , round(786.5427,2) AS round2 -- 소수점 2
            , ceil(786.5427) AS ceilRes
            , FLOOR(786.542) AS floorRes
            , trunc(786.5427,2) AS truncRes
            , mod(10,3) AS "나머지"
            , power(2,10) AS "2의 10승"
FROM  dual;
/*
 * 날짜 함수, 나라마다 표현방식 다름
 * 2025-03-12 아시아
 * March/12/2025 미국, 캐나다, 등
 * 12/marc/2025 유럽, 인도
 */

-- 오늘 날짜
SELECT sysdate -- GMT 기준, +09필요
	-- 날짜 포맷팅 사용되는 YY, YYYY, MM, DD, DAY 년월일
	-- AM/PM, HH, HH24, MI, SS, W, Q(분기)
	 , TO_CHAR(sysdate, 'YYYY-MM-DD') AS 한국식
	 , TO_CHAR(sysdate, 'AM HH24-MI-SS') AS 시간
	 , TO_CHAR(sysdate, 'MON/DD/YYYY') AS 미국식
	 , TO_CHAR(sysdate, 'DD/MM/YYYY') AS 영국식
	FROM dual; 

-- ADD_MONTHS() 월을 추가함수
SELECT hire_date 
	 , add_months(hire_date, 3) AS 정규직일자
	FROM employees;

SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') FROM dual;
ALTER SESSION SET CURRENT_SCHEMA = HR;

SELECT to_char(sysdate + INTERVAL '9' HOUR, 'YYYY-MM-DD HH24:MI')


/* 형 변환 함수 */

-- TO_CHAR()
-- 숫자형을 문자형으로 변경
SELECT 12345 AS 원본
	 , to_char(12345, '9999999') AS "원본+두자리"
	 , to_char(12345, '09999999') AS "원본+두자리0"
	 , to_char(12345, '$99999') AS "통화단위+원본"
	 , to_char(12345, '99999.99') AS "소숫점"
	 , to_char(12345, '99,999') AS "천 단위 쉼표"
	FROM dual;

-- TO_NUMBER() 문자형된 데이터를 숫자로
SELECT '5.0' * 5
	 , TO_NUMBER('5.0') AS 숫자형변환
	FROM dual;

-- TO_DATE() 날짜 형태를 문자형으로
SELECT '2025-03-12'
	 , to_date('2025-03-12') + 10 -- 날짜형으로 바꾸면 연산 가능
	FROM dual;

/* 일반 함수 */
-- NVL(컬럼|데이터, 바꿀값) NULL값을 다른 값으로 치환
SELECT commission_pct
	 , nvl(commission_pct, 0.0)
	 FROM employees; 

SELECT nvl(hire_date, sysdate)
	FROM employees;

SELECT commission_pct
	 , nvl2(commission_pct, salary + (salary * commission_pct), salary)
	 FROM employees; 

/*
 * CASE 구문, 정말 중요!
 * if, elif의 중복된 구문과 유사 -> 적절하게 사용
 */

SELECT CASE job_id WHEN 'AD_PRES' THEN '사장'
				   WHEN 'AD_VP' THEN '부사장'
				   WHEN 'IT_PROG' THEN '프로그래머'
				   WHEN 'SA_MAN' THEN '영업사원'
				   ELSE '미분류'
	END AS 직급
	 , employee_id
	 , job_id
	FROM employees;

/*
 * 정규식(Regula Expression): 문자열 패턴을 가지고, 동일한 패턴 데이터 추출 사용
 * ^, $, ., *, [], [^] 패턴 인식할 때 필요한 키워드
 */
SELECT *
	FROM employees
	WHERE phone_number LIKE '%.%.%';

-- 전화번호가 .으로 구분되는 세자리 전화번호만 필터링
-- '[1-9]{6}-[1-9]{7}' 주민번호 정규식 패턴
SELECT *
	FROM employees
	WHERE REGEXP_LIKE(phone_number, '[1-9]{3}.[1-9]{3}.[1-9]{4}');

-- first_name이 J로 시작하고, 두 번째 글자가 a나 o인 사람을 출력하시오.
SELECT *
	FROM employees
	WHERE REGEXP_LIKE(first_name, '^(a|o)');
