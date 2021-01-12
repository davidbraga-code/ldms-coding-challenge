PROMPT create table departments
CREATE TABLE departments
  (
  dept_id NUMBER(5) PRIMARY KEY,
  dept_name VARCHAR2(50) NOT NULL,
  dept_location VARCHAR2(50) NOT NULL
  );

PROMPT populate table departments
INSERT INTO departments (dept_id, dept_name, dept_location) SELECT 1, 'Management', 'London' FROM DUAL;
INSERT INTO departments (dept_id, dept_name, dept_location) SELECT 2, 'Engineering', 'Cardiff' FROM DUAL;
INSERT INTO departments (dept_id, dept_name, dept_location) SELECT 3, 'Research & Development', 'Edinburgh' FROM DUAL;
INSERT INTO departments (dept_id, dept_name, dept_location) SELECT 4, 'Sales', 'Belfast' FROM DUAL;

CREATE SEQUENCE seq_department START WITH 5 INCREMENT BY 1 NOMAXVALUE;

PROMPT create table employees
CREATE TABLE employees
  (
  emp_id NUMBER(10) PRIMARY KEY,
  emp_name VARCHAR2(50) NOT NULL,
  job_title VARCHAR2(50) NOT NULL,
  manager_id NUMBER(10),
  date_hired DATE NOT NULL,
  salary NUMBER(10) NOT NULL,
  dept_id NUMBER(5) NOT NULL,
  CONSTRAINT employees_fk1 FOREIGN KEY (dept_id) REFERENCES departments (dept_id)
  );

PROMPT populate table employees
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90001, 'John Smith', 'CEO', NULL, TO_DATE('01-JAN-1995', 'DD-MON-RRRR'), 100000, 1 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90002, 'Jimmy Willis', 'Manager', 90001, TO_DATE('23-SEP-2003', 'DD-MON-RRRR'), 52500, 4 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90003, 'Roxy Jones', 'Salesperson', 90002, TO_DATE('11-FEB-2017', 'DD-MON-RRRR'), 35000, 4 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90004, 'Selwyn Field', 'Salesperson', 90003, TO_DATE('20-MAY-2015', 'DD-MON-RRRR'), 32000, 4 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90005, 'David Hallett', 'Engineer', 90006, TO_DATE('17-APR-2018', 'DD-MON-RRRR'), 40000, 2 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90006, 'Sarah Phelps', 'Manager', 90001, TO_DATE('21-MAR-2015', 'DD-MON-RRRR'), 45000, 2 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90007, 'Louise Harper', 'Engineer', 90006, TO_DATE('01-JAN-2013', 'DD-MON-RRRR'), 47000, 2 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90008, 'Tina Hart', 'Engineer', 90009, TO_DATE('28-JUL-2014', 'DD-MON-RRRR'), 45000, 3 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90009, 'Gus Jones', 'Manager', 90001, TO_DATE('15-MAY-2018', 'DD-MON-RRRR'), 50000, 3 FROM DUAL;
INSERT INTO employees (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) SELECT 90010, 'Mildred Hall', 'Secretary', 90001, TO_DATE('12-OCT-1996', 'DD-MON-RRRR'), 35000, 1 FROM DUAL;

CREATE SEQUENCE seq_employee START WITH 90011 INCREMENT BY 1 NOMAXVALUE;
