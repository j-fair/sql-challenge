create table employees
(emp_no int primary key,
emp_title_id varchar(5),
birth_date date,
first_name varchar(25),
last_name varchar(25),
sex varchar(1),
hire_date date);

create table departments
(dept_no varchar(5) primary key,
dept_name varchar(30));

create table titles
(title_id varchar(5) primary key,
title varchar(30));

create table salaries
(emp_no int,
salary int,
foreign key (emp_no)
references employees(emp_no));

create table dept_manager
(dept_no varchar(5) references departments(dept_no),
emp_no int references employees(emp_no))
;

create table dept_emp
(emp_no int references employees(emp_no),
dept_no varchar(5) references departments(dept_no));

--#1
select e.emp_no, first_name, last_name, sex, salary
from employees e inner join salaries s on e.emp_no = s.emp_no
;

--#2
select first_name, last_name, hire_date
from employees
where extract(year from hire_date) = 1986
;

--#3
select d.dept_no, d.dept_name, m.emp_no, first_name, last_name
from departments d
join dept_manager m on d.dept_no = m.dept_no
join employees e on m.emp_no = e.emp_no
;

--#4
select e.emp_no, last_name, first_name, dept_name
from employees e 
join dept_emp de on e.emp_no = de.emp_no
join departments d on d.dept_no = de.dept_no
;

--#5
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%'
;

--#6
select e.emp_no, last_name, first_name, dept_name
from employees e 
join dept_emp de on e.emp_no = de.emp_no
join departments d on d.dept_no = de.dept_no
where dept_name = 'Sales'
;

--#7
select e.emp_no, last_name, first_name, dept_name
from employees e 
join dept_emp de on e.emp_no = de.emp_no
join departments d on d.dept_no = de.dept_no
where dept_name = 'Sales' or dept_name = 'Development'
;

--#8
select last_name, count(last_name) as SharedNameCount
from employees
group by last_name
order by SharedNameCount desc
;