-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

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




