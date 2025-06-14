--테이블 관련 데이터 딕셔너리를 다음과 같이 조회한다.
SELECT COUNT(*) FROM user_tables;
SELECT COUNT(*) FROM all_tables; 
--다른 세션에서 관리자로 로그인하여 테이블관련 정보를 조회한다.
SELECT COUNT(*) FROM user_tables;
SELECT COUNT(*) FROM all_tables;
SELECT COUNT(*) FROM dba_tables;
--다음과 같이 쿼리하여 데이터베이스에 있는 모든 데이터 딕셔너리 뷰의 목록을 확인할 수 있다.
SELECT table_name FROM dictionary ; 



--다음은 CUSTOMERS 테이블을 생성하는 예제이다.
CREATE TABLE customers
(cust_id NUMBER(6),  
 cust_name VARCHAR2(40),  
 phone_no VARCHAR2(15),  
 email VARCHAR2(30),
 birth_date DATE,
 join_date DATE DEFAULT SYSDATE,  
 cust_level NUMBER(1) DEFAULT 9) ;

DESC customers
SELECT table_name FROM user_tables;

--다음 예제는 부서 200에서 일하는 사원들에 대한 정보를 포함하는 DEPT200 테이블을  생성한다. 이 테이블의 데이터는 Y_EMP 테이블로부터 복사된다.
CREATE TABLE dept200
AS SELECT emp_id, emp_name,  salary*12 ANNSAL, hiredate
FROM y_emp
WHERE dept_id = 200;

DESC dept200
SELECT * FROM dept200;

--현재 시간 조회
SELECT systimestamp, current_timestamp FROM dual;
ALTER SESSION SET time_zone = '-10:00';
SELECT systimestamp, current_timestamp FROM dual;
ALTER SESSION SET time_zone = '+09:00';


--TIME_TEST1 테이블에 현재의 날짜를 입력한다.
INSERT INTO time_test1
VALUES(11,SYSDATE,SYSDATE,SYSDATE,SYSDATE);
commit;
SELECT * FROM time_test1;


--TIME ZONE을 이동한 후의 시간정보를 비교해 본다. 
ALTER SESSION SET TIME_ZONE = '-10:00';
SELECT * FROM time_test1;
ALTER SESSION SET time_zone = '+09:00';

--TIME_TEST2 테이블에 데이터를 입력하고 조회한다. 
DESC time_test2
INSERT INTO time_test2
VALUES(1, INTERVAL '10-6' YEAR TO MONTH, INTERVAL '7 12:00:00' DAY TO SECOND);  
COMMIT;
SELECT * FROM time_test2;

--TIME_TEST2 테이블을 이용하여 Y_EMP 테이블에서 사원의 입사일로부터 10년 6개월이 지난 후의 날짜를 알아본다.
SELECT emp_id, hiredate, hiredate+dur1 review_day FROM y_emp, time_test2


--TIME_TEST2 테이블을 이용하여 현재로부터 7일 12시간 후의 날짜 및 시간을 알아본다. 
SELECT SYSTIMESTAMP, SYSTIMESTAMP+dur2 FROM dual, time_test2
WHERE no = 1 ;


--다음 예제에서는 POSITION 열을 DEPT200 테이블에 추가한다.
ALTER TABLE dept200
ADD (position VARCHAR2(10));  
DESC dept200
SELECT * FROM dept200;

--DEPT200 테이블의 HIREDATE 열의 데이터타입을 기존의 DATE타입에서 TIMESTAMP 타입으로 변경한다.
ALTER TABLE dept200 MODIFY hiredate timestamp;
ALTER TABLE dept200 MODIFY position DEFAULT '사원';  
SELECT * FROM dept200;

--다음 예제는 DEPT200 테이블의 기존 행들에대해 POSITION의 값을 지정된 기본값으로 수정하는 것이다.
UPDATE dept200
SET position=DEFAULT;  
COMMIT;
SELECT * FROM dept200;

-- DEPT200 테이블에서 HIREDATE 열을 삭제한 후 확인한다. 
ALTER TABLE dept200 DROP COLUMN hiredate ;  
DESC dept200
--DEPT200 테이블의 ANNSAL열과 POSITION열을 UNUSED COLUMN으로 표시한다.
ALTER TABLE dept200 SET UNUSED (annsal, position);
DESC dept200
SELECT * FROM dept200;
--DEPT200 테이블에서 UNUSED로 표시된 모든 열을 실제 제거한다.
ALTER TABLE dept200
DROP UNUSED COLUMNS;

--EMP300 테이블을 READ ONLY로 설정한 후 DML을 실행해 본다.
ALTER TABLE emp300 READ ONLY;
UPDATE emp300
SET salary = salary*1.1;
ALTER TABLE emp300 READ WRITE;


--CUSTOMERS 테이블을 삭제하고 확인한다.
DROP TABLE customers;
DESC customers
SELECT * FROM tab;  

--FLASHBACK 명령으로 테이블을 복원하고 확인해 본다.
FLASHBACK TABLE customers TO BEFORE DROP;
SELECT * FROM tab;
DESC customers

--PURGE 옵션으로 테이블을 영구삭제한 후 확인한다. 
DROP TABLE customers PURGE;
SELECT * FROM tab;


--EMP300 테이블을 TRUNCATE 한 후 모든 행은 삭제되고 테이블 구조만 남아 있는 것을 다음과 같이 확인한다.
SELECT * FROM emp300;
TRUNCATE TABLE emp300;  
SELECT * FROM emp300;
DESC emp300


--EMP300 테이블의 이름을 DEPT300으로 변경하고 확인해 본다.
RENAME emp300 TO dept300;
DESC emp300  