select count(*) from departments;
select * from employees;
select *from regions;

-- 1. Alias to the table
-- Q1: List all employees using an alias for the employees table.
select * from employees as employees_table;

-- 2. Subquery using NOT IN
-- Q2: Find all employees who are not in any department under the 'Health' division
select first_name,last_name from employees
where department not in (select department from employees 
		where department ='Health'
		)

-- 3. Subquery using SELECT * FROM (subquery)
-- Q3: Show all employee details whose salary is above the average salary.
select * from employees
where salary > (select avg(salary) from employees);

-- 4. Subquery in SELECT, WHERE, FROM
-- Q4: Show each employee's salary and the average salary of their department.

select first_name,department,salary,
(select round(avg(salary)) from employees)
from employees;

-- Q5: List employees who earn more than the average salary in their department.
select first_name,last_name,salary from employees
where salary > (select avg(salary) from employees);


-- Q6: List employees with salary greater than the minimum salary across all regions.
SELECT employee_id,first_name,salary
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees);

-- 5. Subquery using multiple tables
-- Q7: Show names of employees who work in departments that belong to the 'Electronics' division.
select first_name from employees
where department=(select department from employees
					where department='Electronics')

-- 6. ANY and ALL operations
-- Q8: List employees who earn more than ALL employees in the 'Books' department.
SELECT employee_id,first_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department = 'Books'
);

-- Q9: List employees whose salary is greater than ANY employee from 'Tools' department.

SELECT employee_id,first_name,salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'Tools'
);

-- 7. Bonus Practice
-- Q10: Find departments where the average salary is higher than the average salary across all employees.
SELECT department, round(AVG(salary)) AS dept_avg
FROM employees
GROUP BY department
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- Q11: List departments that have more than 5 employees.
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Q12: List employees whose salary is the highest within their department (no JOIN).
SELECT employee_id,first_name, department, salary
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = e.department
);

-- Q13: Find regions with at least one employee earning above 150000.
SELECT DISTINCT region
FROM employee
WHERE salary > 150000;

-- Q14: Display employees who are working in departments that are not listed in the departments table.
select *
from employees e
where e.department not in (select department from departments)

-- Q15: Find the employee(s) with the earliest hire date (without using ORDER BY or LIMIT).
SELECT employee_id,first_name, hire_date
FROM employees
WHERE hire_date = (SELECT MIN(hire_date) FROM employees);









