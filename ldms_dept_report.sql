SET ECHO OFF
SET TERMOUT OFF
SET HEADING ON
SET LINESIZE 100
SET PAGESIZE 1
SET SERVEROUTPUT ON SIZE 100000
accept department prompt 'Enter department name:'
column emp_name format a50 heading 'Employee'
column job_title format a50 heading 'Job Title'
column manager format a50 heading 'Manager'
column date_hired format a11
column salary format '£99999.00'
SPOOL department_report.txt
select emp.emp_name, emp.job_title, man.emp_name manager, to_char(emp.date_hired, 'DD-MON-RRRR') date_hired, emp.salary
from employees emp, employees man, departments dept
where emp.manager_id = man.emp_id(+)
and emp.dept_id = dept.dept_id
and dept.dept_name = '&&department'
order by salary desc;
spool off
