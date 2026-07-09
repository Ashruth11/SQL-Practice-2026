-- SQL Join Practice – Question Set

-- Level 1: Basic Joins
-- 1. List all employees along with their region name and country.
select e.employee_id,e.first_name,e.last_name,r.region,r.country
from employees e
join regions r
on e.region_id=r.region_id;

-- 2. Display each employee's department and its division.
select e.employee_id,e.first_name,d.*
from employees e
join departments d
on e.department=d.department

-- 3. How many employees are there in each region?
select r.region,count(e.employee_id) as no_of_employees
from employees e
join regions r
on e.region_id=r.region_id
group by r.region

-- Level 2: Joins with Aggregation
-- 4. What is the average salary in each division?
select d.division,round(avg(e.salary)) as avg_salary
from employees e
join departments d
on e.department=d.department
group by division;

-- 5. Which regions have more than 10 employees?
select r.region,count(e.employee_id) as no_of_employees
from employees e
join regions r
on e.region_id=r.region_id
group by r.region
having count(e.employee_id)>10

-- 6. Find the top 3 departments with the highest average salary.
select d.department,round(avg(e.salary)) as avg_salary
from employees e
join departments d
on e.department=d.department
group by d.department
order by avg_salary desc
limit 3;

-- 7. Show the number of male and female employees in each region.
select r.region,
	sum(case
			when e.gender='M' then 1 else 0
		end) as male,
	sum(case
			when e.gender='F' then 1 else 0
		end) as female
from employees e 
join regions r
on r.region_id=e.region_id
group by r.region;

-- Level 3: Outer Joins and Missing Data
-- 8. List all departments, including those with no employees.
select d.department,e.*
from employees e
right join departments d
on d.department=e.department

SELECT d.department, e.*
FROM employees e
RIGHT JOIN departments d ON d.department = e.department;


-- 9. Which regions don't have any employees assigned?
select r.region,r.country
from regions r
left join employees e
	on e.region_id=r.region_id
where e.employee_id is null;

-- 10. Compare average salaries of employees hired before and after 2010 by department.
select  d.department,
	   round(avg(case
	   		when extract(year from hire_date)<=2010 then e.salary
			else null
	   end)) as before_2010,
	   round(avg(case
	   		when extract(year from hire_date)>2010 then e.salary
			else null
	   end)) as after_2010
from employees e
join departments d
	on e.department=d.department
group by d.department

-- Level 4: Case-Based Challenges
-- 11. List all divisions that have employees in more than 2 regions.
select d.division,COUNT(DISTINCT r.region_id) AS region_count
from employees e
join regions r on e.region_id=r.region_id
join departments d on e.department=d.department
group by d.division
having COUNT(DISTINCT r.region_id) > 2

-- 12. Create a report of total salary paid by country and division.
select r.country,d.division,sum(e.salary) as total_salary
from employees e
join regions r on e.region_id=r.region_id
join departments d on e.department=d.department
group by r.country,d.division
order by total_salary desc

-- 13. List departments with average salary below 60,000 and more than 3 employees.

select  d.department,round(avg(e.salary)) as avg_salary,count(e.employee_id) as employee_count
from employees e
join departments d
	on e.department=d.department
group by d.department
having count(e.employee_id) > 3 and avg(e.salary) < 60000











