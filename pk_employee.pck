CREATE OR REPLACE PACKAGE pk_employee AS
  FUNCTION create_employee(p_name VARCHAR2, p_job_title VARCHAR2, p_manager_id NUMBER, p_date_hired DATE, p_salary NUMBER, p_dept_id NUMBER) RETURN NUMBER;
  PROCEDURE salary_adjust(p_employee_id NUMBER, p_salary_adjust_percent NUMBER);
  PROCEDURE transfer_employee (p_employee_id NUMBER, p_new_dept_id NUMBER, p_new_manager_id NUMBER);
  FUNCTION get_salary(p_employee_id NUMBER) RETURN NUMBER;
END pk_employee;
/
CREATE OR REPLACE PACKAGE BODY pk_employee AS
  FUNCTION get_emp_name (p_emp_id NUMBER) RETURN VARCHAR2 IS
    CURSOR c1 IS
    SELECT emp_name
    FROM employees
    WHERE emp_id = p_emp_id;
    v_name employees.emp_name%TYPE;
  BEGIN
    OPEN c1;
    FETCH c1 INTO v_name;
    CLOSE c1;
    RETURN v_name;
  END get_emp_name;
  
  FUNCTION create_employee
      (
      p_name VARCHAR2, 
      p_job_title VARCHAR2, 
      p_manager_id NUMBER, 
      p_date_hired DATE, 
      p_salary NUMBER, 
      p_dept_id NUMBER
      ) 
  RETURN NUMBER IS
    
    v_emp_id employees.emp_id%TYPE;
    
    e_name_exists EXCEPTION;
    
    e_invalid_manager EXCEPTION;
    e_invalid_dept EXCEPTION;
    
    e_missing_name EXCEPTION;
    e_missing_job_title EXCEPTION;
    e_missing_date EXCEPTION;
    e_missing_salary EXCEPTION;
    e_missing_department EXCEPTION;
  BEGIN
    IF p_name IS NULL THEN
      RAISE e_missing_name;
    ELSIF p_job_title IS NULL THEN
      RAISE e_missing_job_title;
    ELSIF p_date_hired IS NULL THEN
      RAISE e_missing_date;
    ELSIF p_salary IS NULL THEN
      RAISE e_missing_salary;
    ELSIF p_dept_id IS NULL THEN
      RAISE e_missing_department;
    END IF;
    
    SELECT seq_employee.NEXTVAL INTO v_emp_id FROM DUAL;

    INSERT INTO employees  (emp_id, emp_name, job_title, manager_id, date_hired, salary, dept_id) 
    VALUES (v_emp_id, p_name, p_job_title, p_manager_id, p_date_hired, p_salary, p_dept_id);
    
    RETURN v_emp_id;
  EXCEPTION
    WHEN e_missing_name THEN
      --log suitable error message
      RETURN -1;
    WHEN e_missing_job_title THEN
      --log suitable error message
      RETURN -1;
    WHEN e_missing_date THEN
      --log suitable error message
      RETURN -1;
    WHEN e_missing_salary THEN
      --log suitable error message
      RETURN -1;
    WHEN e_missing_department THEN
      --log suitable error message
      RETURN -1;
    WHEN OTHERS THEN
      --log suitable error message
      RETURN -1;
  END create_employee;
  
  PROCEDURE salary_adjust
    (
    p_employee_id NUMBER, 
    p_salary_adjust_percent NUMBER
    ) 
  IS
    e_missing_id EXCEPTION;
    e_invalid_employee_id EXCEPTION;
    e_missing_percent EXCEPTION;
  BEGIN
    IF p_employee_id IS NULL THEN
      RAISE e_missing_id;
    ELSIF p_salary_adjust_percent IS NULL THEN
      RAISE e_missing_percent;
    ELSIF get_emp_name(p_employee_id) IS NULL THEN
      RAISE e_invalid_employee_id;
    END IF;
    --adjust employee salary
    UPDATE employees
    SET salary = salary+((salary/100)*p_salary_adjust_percent)
    WHERE emp_id = p_employee_id;
  EXCEPTION
    WHEN e_missing_id THEN
      --log suitable error message
      NULL;
    WHEN e_missing_percent THEN
      --log suitable error message
      NULL;
    WHEN e_invalid_employee_id THEN
      --log suitable error message
      NULL;
    WHEN OTHERS THEN
      --log suitable error message
      NULL;
  END salary_adjust;
  
  PROCEDURE transfer_employee (p_employee_id NUMBER, p_new_dept_id NUMBER, p_new_manager_id NUMBER) IS
    CURSOR c1 IS
    SELECT dept_id
    FROM employees
    WHERE emp_id = p_new_manager_id;
    
    CURSOR c2 IS
    SELECT dept_id
    FROM departments
    WHERE dept_id = p_new_dept_id;
    
    v_manager_dept_id employees.dept_id%TYPE;
    v_dept_id departments.dept_id%TYPE;
    
    e_missing_employee_id EXCEPTION;
    e_invalid_employee_id EXCEPTION;
    e_missing_dept_id EXCEPTION;
    e_invalid_dept_id EXCEPTION;
    e_missing_manager_id EXCEPTION;
    e_dept_mismatch EXCEPTION;
  BEGIN
    IF p_employee_id IS NULL THEN
      RAISE e_missing_employee_id;
    ELSIF get_emp_name(p_employee_id) IS NULL THEN
      RAISE e_invalid_employee_id;
    ELSIF p_new_dept_id IS NULL THEN
      RAISE e_missing_dept_id;
    ELSIF p_new_manager_id IS NULL THEN
      RAISE e_missing_manager_id;
    END IF;
    
    OPEN c1;
    FETCH c1 INTO v_manager_dept_id;
    CLOSE c1;
    OPEN c2;
    FETCH c2 INTO v_dept_id;
    CLOSE c2;
    IF v_dept_id IS NULL THEN
      RAISE e_invalid_dept_id;
    ELSIF v_manager_dept_id != v_dept_id THEN
      RAISE e_dept_mismatch;
    END IF;
    
    UPDATE employees
    SET dept_id = v_dept_id,
        manager_id = p_new_manager_id
    WHERE emp_id = p_employee_id;
  EXCEPTION
    WHEN e_missing_employee_id THEN
      --log suitable error message
      NULL;
    WHEN e_invalid_employee_id THEN
      --log suitable error message
      NULL;
    WHEN e_missing_dept_id THEN
      --log suitable error message
      NULL;
    WHEN e_missing_manager_id THEN
      --log suitable error message
      NULL;
    WHEN e_invalid_dept_id THEN
      --log suitable error message
      NULL;
    WHEN e_dept_mismatch THEN
      --log suitable error message
      NULL;
  END transfer_employee;
  
  FUNCTION get_salary(p_employee_id NUMBER) RETURN NUMBER IS
    CURSOR c1 IS
    SELECT salary
    FROM employees
    WHERE emp_id = p_employee_id;
    v_salary employees.salary%TYPE;
  BEGIN
    OPEN c1;
    FETCH c1 INTO v_salary;
    CLOSE c1;
    RETURN v_salary;
  END get_salary;
END pk_employee;
/
