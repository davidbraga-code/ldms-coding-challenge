SET ECHO OFF
SET TERMOUT OFF
SET HEADING ON
SET LINESIZE 100
SET PAGESIZE 1
SET SERVEROUTPUT ON SIZE 100000
column dept_name format a50 heading 'Department'
column salary format '£99999.00' heading 'Salary'
SPOOL department_salary_report.txt
select dept.dept_name, sum(emp.salary) salary
from employees emp, departments dept
where emp.dept_id = dept.dept_id
group by dept.dept_name
order by salary desc;
spool off
