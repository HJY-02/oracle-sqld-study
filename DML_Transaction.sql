INSERT INTO y_dept(dept_id, dept_name, mgr_id, loc_id)
VALUES(600,'생산관리',1083,6);

--위에 있는 방식과 똑같다.
INSERT INTO y_dept
VALUES(600,'생산관리',1083,6);

SELECT *
FROM y_dept;

--목록에 입력한 열만 지정하여 암시적으로 NULL값 생성
INSERT INTO y_dept(dept_id, dept_name)
VALUES(700,'회계부');

--열 개수를 맞추기 위해 명시적으로 NULL을 입력
INSERT INTO y_dept
VALUES(800,'시스템관리',NULL,NULL);

INSERT INTO y_emp(emp_id, emp_name, hiredate, dept_id)
VALUES(2007, '박민영', SYSDATE, 700);

SELECT emp_id, emp_name, hiredate, dept_id
FROM y_emp
WHERE emp_id = 2007;

COMMIT;

INSERT INTO y_emp(emp_id, emp_name, hiredate)
VALUES (2008, '윤현민', TO_DATE('99/02/03', 'YY/MM/DD'));//2099
INSERT INTO y_emp(emp_id, emp_name, hiredate)
VALUES (2009, 'Jason Lee', TO_DATE('99/02/03', 'RR/MM/DD'));//1999

SELECT emp_id, emp_name, TO_CHAR(hiredate,'yyyy/mm/dd')
FROM y_emp
WHERE emp_id IN (2008,2009);

INSERT INTO emp300
SELECT emp_id, emp_name, salary, dept_id
FROM y_emp
WHERE dept_id = 300;
SELECT * FROM emp300;
COMMIT;

UPDATE emp300
SET dept_id = 400
WHERE emp_id = 1037;

select * from emp300;

UPDATE emp300
SET dept_id=80;
SELECT * FROM emp300;

UPDATE emp300
SET salary=700
WHERE emp_id=1056;

ROLLBACK;

UPDATE emp300
SET salary = (SELECT salary 
              FROM y_emp
              WHERE emp_id = 1038),
    dept_id = (SELECT dept_id 
               FROM y_emp
               WHERE emp_id = 1038)
WHERE emp_id= 1087;

SELECT * FROM emp300;
COMMIT;

DELETE FROM emp300
WHERE emp_id=1019;

DELETE FROM emp300;
COMMIT;

DESC emp300
SELECT * FROM emp300;

DELETE FROM y_emp
WHERE dept_id = (SELECT dept_id
                 FROM y_dept
                 WHERE dept_name LIKE '%회계%');
                 
ROLLBACK;

DESC old_emp
SELECT * FROM old_emp;

MERGE INTO old_emp o
USING y_emp e
ON (o.emp_id = e.emp_id)
WHEN MATCHED THEN
UPDATE SET
o.emp_name = e.emp_name,
o.position = e.position,
o.salary = e.salary,
o.dept_id = e.dept_id
DELETE 
WHERE (e.position IS NULL)
WHEN NOT MATCHED THEN
INSERT VALUES(e.emp_id, e.emp_name,e.position, e.salary, e.dept_id);

COMMIT;
SELECT * FROM old_emp;

INSERT INTO emp300
SELECT emp_id, emp_name, salary, dept_id
FROM y_emp
WHERE dept_id =300;
COMMIT;
SELECT * FROM emp300;

SELECT * FROM emp300;
UPDATE emp300
SET salary = 600
WHERE emp_id = 1037;
SAVEPOINT s1;
UPDATE emp300
SET salary = 670
WHERE emp_id = 1081;
SAVEPOINT s2;
UPDATE emp300
SET salary = salary*1.2
WHERE emp_id IN (1087,1097);
SAVEPOINT s3;
DELETE FROM emp300
WHERE emp_id = 1019;
SELECT * FROM emp300;

ROLLBACK TO s3;
SELECT * FROM emp300;
ROLLBACK TO s2;
SELECT * FROM emp300;
ROLLBACK;
SELECT * FROM emp300;