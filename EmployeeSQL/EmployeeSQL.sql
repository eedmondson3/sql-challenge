-- Creating the tables for departments, dept_emp, dept_manager, 
-- employees, salaries, and titles

CREATE TABLE departments (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
CREATE TABLE dept_emp (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL
);

CREATE TABLE dept_manager (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE employees (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(30)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(30)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE salaries (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE titles (
    "title_id" varchar(30)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

-- Task #1 List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, 
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
ORDER BY emp_no

-- Task #2 List the first name, last name, and hire date 
-- for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date ASC;

-- Task #3 List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
SELECT departments.dept_no, 
departments.dept_name, 
dept_manager.emp_no, 
employees.last_name, 
employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- Task #4 List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
SELECT dept_emp.dept_no, 
dept_emp.emp_no, 
employees.last_name, 
employees.first_name, 
departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--  Task #5 List the first name, last name, and sex 
-- of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name, 
employees.last_name, 
employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

-- Task #6 List each employee in the Sales department, 
-- including their employee number, last name, and first name.
SELECT departments.dept_name, 
employees.last_name, 
employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- Task #7 List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, 
employees.last_name, 
employees.first_name, 
departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- Task #8 List the frequency counts, in descending order, 
-- of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;