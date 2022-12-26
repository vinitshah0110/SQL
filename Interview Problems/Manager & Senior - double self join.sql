/* Write a sql query to list emp_name along with their manager and senior manager name

Schema:
create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int
);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39), (2, 'Mohit', 100, 15000, 5, 48),(3, 'Vikas', 100, 12000,4,37),(4, 'Rohit', 100, 14000, 2, 16),
(5, 'Mudit', 200, 20000, 6,55),(6, 'Agam', 200, 12000,2, 14),(7, 'Sanjay', 200, 9000, 2,13),(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),(10, 'Rakesh',500,7000,6,50); */

-- Solution:
select e1.emp_id, e1.emp_name, e2.emp_name as 'manager_name', e3.emp_name as 'senior_manager_name'
from emp e1 join emp e2
on e1.manager_id = e2.emp_id
join emp e3
on e2.manager_id = e3.emp_id
order by 1;