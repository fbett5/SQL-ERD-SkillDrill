-- Select all the employees who were born between January 1, 1952 and December 31, 1955 and their titles and title date ranges
-- Order the results by emp_no
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;


-- Select only the current title for each employee
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name , title   
INTO current_titles
FROM retirement_titles
ORDER BY emp_no,to_date desc;

select  * from current_titles;

-- Count the total number of employees about to retire by their current job title
SELECT DISTINCT COUNT(emp_no), title 
INTO retire_title
FROM current_titles 
GROUP BY title 
ORDER BY COUNT(emp_no) DESC;

--Joining the dept_emp with employees to create  new_dpt_employees table
select de.emp_no, de.dept_no, emp.first_name, emp.last_name
into new_dpt_employees
from dept_emp as de inner join employees as emp on de.emp_no = emp.emp_no;

-- Count the total number of employees per department
select dp.dept_name, count(*) into all_dept_emp
from departments as dp inner join 
new_dpt_employees as nd on dp.dept_no = nd.dept_no 
group by dp.dept_name;

select * from departments;
select * from dept_manager;
select * from salaries

-- Bonus: Find the highest salary per department and department manager
SELECT dp.dept_name, dm.dept_no, dm.emp_no, sal.salary INTO High_Salaries 
FROM (departments dp JOIN  dept_manager dm on dp.dept_no = dm.dept_no)
JOIN salaries sal on sal.emp_no = dm.emp_no;

select * from High_Salaries;
SELECT dept_name, max (salary) highest_salary from High_Salaries
group by dept_name
ORDER BY highest_salary desc;
SELECT emp_no, max (salary) highest_salary from High_Salaries 
group by emp_no;