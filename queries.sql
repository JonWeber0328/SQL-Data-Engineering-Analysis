-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
create view employee_details as
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
left join salaries s
on e.emp_no = s.emp_no;

-- View the table
select * from employee_details;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
create view unique_year_hires as
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31';

-- View the table
select * from unique_year_hires;

-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name.
create view manager as
select m.dept_no, m.emp_no, d.dept_name, e.last_name, e.first_name
from dept_manager as m
left join employees e
on m.emp_no = e.emp_no
left join departments as d
on m.dept_no = d.dept_no;

-- View the table
select * from manager;

-- 4. List the department of each employee with the following information: employee number, 
--    last name, first name, and department name.
create view employee_dept as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
left join dept_emp p
on e.emp_no = p.emp_no
left join departments d
on p.dept_no = d.dept_no;

-- View the table
select * from employee_dept;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" 
--    and last names begin with "B."
create view hercules as
select e.first_name, e.last_name, e.sex
from employees as e
where first_name = 'Hercules'
and last_name like 'B%';

-- View the table
select * from hercules;

-- 6. List all employees in the Sales department, including their employee number, 
--    last name, first name, and department name.
create view employee_sales_dept as
select e.emp_no, e.last_name, e.first_name, e.dept_name
from employee_dept as e
where dept_name = 'Sales'

-- View the table
select * from employee_sales_dept;

-- 7. List all employees in the Sales and Development departments, including their 
--    employee number, last name, first name, and department name.
create view sales_developement as
select e.emp_no, e.last_name, e.first_name, e.dept_name
from employee_dept as e
where dept_name = 'Sales' or dept_name = 'Development';

-- View the table
select * from sales_developement;

-- 8. In descending order, list the frequency count of employee last names, i.e., 
--    how many employees share each last name.
create view frequency_count as
select last_name, count(last_name) as "last_count"
from employees
group by last_name
order by "last_count" desc;

-- View the table
select * from frequency_count;