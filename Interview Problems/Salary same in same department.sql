/* Write a sql query to return all employee whose salary is same in same department

Schema:
CREATE TABLE emp_salary
(
    emp_id INTEGER,
    name NVARCHAR(20),
    salary NVARCHAR(30),
    dept_id INTEGER
);

INSERT INTO emp_salary
(emp_id, name, salary, dept_id) VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11'); */

-- Solution 1:
with cte as(
  select *,
  count(salary) over(partition by dept_id, salary) as 'cnt'
  from emp_salary
)

select emp_id, name, salary, dept_id 
from cte where cnt>1;

-- Solution 2:
select e1.*
from emp_salary e1 join emp_salary e2
on e1.dept_id = e2.dept_id and e1.salary = e2.salary and e1.emp_id != e2.emp_id
order by 4, 1;