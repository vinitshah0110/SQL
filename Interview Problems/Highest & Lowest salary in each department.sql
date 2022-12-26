/* Write a sql query to print highest and lowest salary emp in each department

create table employee 
(
emp_name varchar(10),
dept_id int,
salary int
);

insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000); */

-- Solution 1:
with cte as(
  select *,
  dense_rank() over(partition by dept_id order by salary) as 'min_rank',
  dense_rank() over(partition by dept_id order by salary desc) as 'max_rank'
  from employee
)

, min_sal as(
  select dept_id, emp_name
  from cte where min_rank=1
)

, max_sal as(
  select dept_id, emp_name
  from cte where max_rank=1
)

select max_sal.dept_id, max_sal.emp_name as 'emp_name_max_salary', min_sal.emp_name as 'emp_name_min_salary'
from max_sal join min_sal
on max_sal.dept_id = min_sal.dept_id;

-- Solution 2:
select dept_id,
max(case when max_rank=1 then emp_name end) as 'emp_name_max_salary',
max(case when min_rank=1 then emp_name end) as 'emp_name_min_salary'
from cte
group by dept_id;