SELECT * FROM y_award;

--UNION
SELECT emp_id FROM y_emp
UNION
SELECT emp_id FROM y_award;

SELECT emp_id, position FROM y_emp
UNION
SELECT emp_id, position FROM y_award;

--UNION ALL
SELECT emp_id, position
FROM y_emp
UNION ALL
SELECT emp_id, position
FROM y_award;

--INTERSECT
SELECT emp_id, emp_name, dept_id
FROM y_emp
INTERSECT
SELECT emp_id, awardee, dept_id
FROM y_award;

SELECT emp_id, emp_name, position
FROM y_emp
INTERSECT
SELECT emp_id, awardee, position
FROM y_award;

--MINUS 연산자
SELECT emp_id, awardee
FROM y_award
MINUS
SELECT emp_id, emp_name
FROM y_emp;

SELECT emp_id, emp_name FROM y_emp
MINUS
SELECT emp_id, awardee FROM y_award;

--두 SELECT 문장에서 대응하여 사용된 열의 수가 틀려서 발생하는 오류
SELECT emp_id FROM y_award
UNION
SELECT emp_id, position FROM y_emp;


SELECT emp_id, emp_name, position, mgr_id
FROM y_emp
START WITH emp_id=1001
CONNECT BY PRIOR emp_id=mgr_id;


SELECT emp_id, emp_name, position, mgr_id
FROM y_emp
START WITH emp_id=1019
CONNECT BY PRIOR emp_id=mgr_id;


SELECT emp_id, emp_name, position, mgr_id
FROM y_emp
START WITH emp_id=1019
CONNECT BY emp_id=PRIOR mgr_id;


SELECT emp_id, emp_name, SYS_CONNECT_BY_PATH(emp_id,'/') path
FROM y_emp
START WITH emp_id=1001
CONNECT BY PRIOR emp_id=mgr_id;


SELECT emp_id, emp_name, mgr_id, level
FROM y_emp
START WITH emp_id=1001
CONNECT BY PRIOR emp_id=mgr_id;

SELECT emp_id, emp_name, mgr_id, level
FROM y_emp
START WITH emp_id=1035
CONNECT BY PRIOR emp_id=mgr_id;

SELECT LPAD(emp_id, LENGTH(emp_id)+(LEVEL*2)-2,'-') AS CHART
FROM y_emp
START WITH emp_id = 1001
CONNECT BY PRIOR emp_id=mgr_id;

SELECT LPAD(emp_id, LENGTH(emp_id)+(LEVEL*2)-2,'-') AS CHART
FROM y_emp
WHERE emp_id <> 1002
START WITH emp_id = 1001
CONNECT BY PRIOR emp_id=mgr_id;


SELECT LPAD(emp_id, LENGTH(emp_id)+(LEVEL*2)-2,'-') AS CHART
FROM y_emp
START WITH emp_id = 1001
CONNECT BY PRIOR emp_id=mgr_id
AND emp_id <> 1002;
