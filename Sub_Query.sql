--서브쿼리가 NULL이면 메인쿼리의 결과도 없다.
SELECT emp_id, emp_name, position
FROM y_emp
WHERE mgr_id=(SELECT mgr_id FROM y_emp
              WHERE emp_id=1045);
              
SELECT emp_name, salary, dept_id
FROM y_emp
WHERE salary IN (SELECT MAX(salary)
                 FROM y_emp
                 WHERE dept_id<=200
                 GROUP BY dept_id);
                 
SELECT emp_id, emp_name, position, salary
FROM y_emp
WHERE salary<ANY(SELECT salary FROM y_emp
                 WHERE position='대리')
AND position<>'대리';
              
-------------------------------------------------
--다중 열 서브 쿼리의 비쌍 비교
SELECT emp_id, emp_name, position, dept_id
FROM y_emp
WHERE (position, dept_id) IN (SELECT position, dept_id
                              FROM y_emp
                              WHERE emp_name LIKE '차%')
                              AND emp_name NOT LIKE '차%';

SELECT emp_id, emp_name, position, dept_id
FROM y_emp
WHERE position IN (SELECT position
                   FROM y_emp
                   WHERE emp_name LIKE '차%')
AND dept_id IN (SELECT dept_id
                  FROM y_emp
                  WHERE emp_name LIKE '차%')                            
AND emp_name NOT LIKE '차%';

--상호 관련 서브 쿼리
SELECT emp_name, salary, dept_id
FROM y_emp outer
WHERE salary>(SELECT AVG(salary) 
              FROM y_emp
              WHERE dept_id=outer.dept_id);

SELECT emp_id, emp_name, position, dept_id
FROM y_emp o
WHERE EXISTS(SELECT 'X' FROM y_emp
             WHERE mgr_id=o.emp_id);

SELECT emp_id, emp_name, position, dept_id
FROM y_emp o
WHERE NOT EXISTS(SELECT 'X' FROM y_emp
             WHERE mgr_id=o.emp_id);

---------------------------------------
--인라인뷰
SELECT a.emp_name, a.salary, a.dept_id, b.salavg
FROM y_emp a JOIN (SELECT dept_id, AVG(salary) salavg 
                   FROM y_emp
                   GROUP BY dept_id) b
ON(a.dept_id=b.dept_id)
AND a.dept_id<400
AND a.salary>b.salavg;

-----------------------------------------
--Top-N
SELECT ROWNUM as RANK, emp_id, emp_name, salary
FROM (SELECT emp_id, emp_name, salary
      FROM y_emp
      WHERE salary IS NOT NULL
      ORDER BY salary DESC)
      WHERE ROWNUM<=5;
      
SELECT ROWNUM as RANK, E.emp_name, E.hiredate
FROM (SELECT emp_name, hiredate
      FROM y_emp
      ORDER BY hiredate)E
      WHERE ROWNUM<=3;

------------------------------------------------
--기타 서브 쿼리 사용
SELECT emp_id, emp_name,
        (CASE WHEN dept_id =
                    (SELECT dept_id FROM y_dept
                    WHERE loc_id =4)
                    THEN '대구' ELSE '기타' END) loc_name
FROM y_emp;

SELECT emp_id, emp_name
FROM y_emp e
ORDER BY (SELECT dept_name FROM y_dept d
WHERE e.dept_id = d.dept_id) ;
------------------------------------------------
--WITH절
WITH
    dept_total_sal AS (SELECT d.dept_name, SUM(e.salary) AS dept_total
                        FROM y_emp e JOIN y_dept d
                        ON (e.dept_id = d.dept_id)
                        GROUP BY d.dept_name),
    total_avg_sal AS (SELECT SUM(dept_total)/COUNT(*) AS dept_avg
                      FROM dept_total_sal)
SELECT * 
FROM dept_total_sal
WHERE dept_total > (SELECT dept_avg
                    FROM total_avg_sal);







