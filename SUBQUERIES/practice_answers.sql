-- Q1: Find the most senior (earliest hired) employee in each region using subqueries only.
SELECT * FROM employees e
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM employees e2
    WHERE e2.region_id = e.region_id
);

-- Q2: List departments where all employees earn more than the average salary of the entire company.
SELECT DISTINCT department FROM employees e1
WHERE NOT EXISTS (
    SELECT * FROM employees e2
    WHERE e1.department = e2.department
    AND e2.salary <= (SELECT AVG(salary) FROM employees)
);

-- Q3: List employees whose salary is more than 1.5 times the average salary of their department.
select *
from employees e
where salary > 1.5*(Select avg(salary)
					from employees e2
					where e.department=e2.department)

-- Q4: Find the highest paid employee in each division using only subqueries.
SELECT e.employee_id,e.first_name,e.salary,d.division
FROM employees e
JOIN departments d
  ON e.department = d.department
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = e.department
);

-- Q5: Identify regions that have the most departments with average salary greater than 100000.
SELECT region_id FROM (
    SELECT region_id, COUNT(DISTINCT department) AS high_pay_dept_count
    FROM employees
    WHERE department IN (
        SELECT department FROM employees
        GROUP BY department
        HAVING AVG(salary) > 100000
    )
    GROUP BY region_id
) AS region_stats
WHERE high_pay_dept_count = (
    SELECT MAX(dept_count) FROM (
        SELECT COUNT(DISTINCT department) AS dept_count
        FROM employees
        WHERE department IN (
            SELECT department FROM employees
            GROUP BY department
            HAVING AVG(salary) > 100000
        )
        GROUP BY region_id
    ) AS dept_counts
);



