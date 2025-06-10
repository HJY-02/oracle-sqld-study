SELECT * FROM cust_grade;

CREATE TABLE customers
(cust_id NUMBER(6) CONSTRAINT cust_custid_pk PRIMARY KEY,
cust_name VARCHAR2(40) CONSTRAINT cust_name_nn NOT NULL,
phone_no VARCHAR2(15) NOT NULL,
email VARCHAR2(30),
birth_date DATE,
join_date DATE DEFAULT SYSDATE,
cust_level NUMBER(1) DEFAULT 9,
CONSTRAINT cust_level_fk FOREIGN KEY (cust_level)
REFERENCES cust_grade(cust_level));

DESC customers;

SELECT constraint_name, constraint_type FROM user_constraints
WHERE table_name = 'CUSTOMERS';

--기존 테이블 제약 조건 추가
ALTER TABLE y_emp
ADD CONSTRAINT emp_empid_pk PRIMARY KEY(emp_id);
ALTER TABLE y_dept
ADD CONSTRAINT dept_deptid_pk PRIMARY KEY(dept_id);

ALTER TABLE y_emp
ADD CONSTRAINT emp_deptid_fk FOREIGN KEY(dept_id)
REFERENCES y_dept(dept_id)
ON DELETE SET NULL;

ALTER TABLE y_emp
ADD CONSTRAINT emp_mgrid_fk FOREIGN KEY(mgr_id)
REFERENCES y_emp(emp_id);

ALTER TABLE y_emp
ADD CONSTRAINT emp_sal_ck CHECK (salary BETWEEN 130 AND 1500);

ALTER TABLE y_emp
ADD CONSTRAINT emp_email_uk UNIQUE(email);

DELETE FROM y_dept
WHERE dept_id = 300;

SELECT emp_id, emp_name, dept_id
FROM y_emp ;

SELECT *
FROM y_dept;

ROLLBACK;
SELECT emp_id, emp_name, dept_id FROM y_emp ;

ALTER TABLE y_dept
DISABLE CONSTRAINT dept_deptid_pk ;

ALTER TABLE y_dept
DISABLE CONSTRAINT dept_deptid_pk CASCADE;

SELECT table_name, constraint_name, status
FROM user_constraints
WHERE table_name IN ('Y_EMP', 'Y_DEPT');

--pk가 비활성화된 상태에서 잘못된 데이터를 입력해도 아무오류없이 저장되는 것을 볼 수 있다.
--원래였으면 dept_id가 중복저장되어 오류가 나야한다
INSERT INTO y_dept(dept_id, dept_name) VALUES (200, '서비스');
COMMIT;

DESC y_dept

--활성화할려고 시도하면 중복되는 데이터가 발견되어 명령문이 실패한다.
ALTER TABLE y_dept ENABLE PRIMARY KEY;

--잘못된 데이터를 삭제하여 오류 수정.
--값이 중복되는 데이터를 삭제하는 경우 ROWID활용할 수 있다.
SELECT dept_id, dept_name, rowid FROM y_dept;
DELETE FROM y_dept
WHERE rowid = 'AAAFOKAAEAAAAINAAA';
COMMIT;

ALTER TABLE y_dept ENABLE PRIMARY KEY;

SELECT table_name, constraint_name, status FROM USER_CONSTRAINTS
WHERE table_name IN ('Y_EMP','Y_DEPТ') ;
ALTER TABLE y_emp ENABLE CONSTRAINT EMP_DEPTID_FK;


SELECT constraint_name, r_constraint_name, status
FROM USER_CONSTRAINTS
WHERE table_name = 'Y_EMP';
ALTER TABLE y_emp DROP PRIMARY KEY CASCADE;
SELECT constraint_name, r_constraint_name, status
FROM USER_CONSTRAINTS
WHERE table_name = 'Y_EMP';

DESC user_cons_columns

ALTER TABLE y_emp
ADD PRIMARY KEY(emp_id);
ALTER TABLE y_emp
ADD FOREIGN KEY(mgr_id) REFERENCES y_emp(emp_id);

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'Y_EMP';

SELECT constraint_name, column_name
FROM user_cons_columns WHERE table_name = 'Y_EMP';

SELECT c.constraint_name, cc.column_name, c.constraint_type
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'Y_EMP';
