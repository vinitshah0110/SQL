/* Recursive CTE contains all the people that directly or indirectly report to Dwight, assistant manager.

-- schema:
create table employee(
  employee_name varchar(20),
  manager_name varchar(20)
);

insert into employee() values('Dwight','Michael'),('Jim','Michael'),('Pam','Dwight'),('Angela','Dwight'),('Meredith','Jim'),
('Oscar','Pam'),('Kelly','Pam'),('Stanley','Angela'),('Max','Stanley'); */

-- Solution:
with recursive cte as(
  /* Base term: non-recursive part */
  select employee_name, 1 as 'level' from employee
  where manager_name = 'Dwight'
  union
  /* recursive part */
  select employee.employee_name, level+1 as 'level'
  from employee join cte
  on employee.manager_name = cte.employee_name
)

select * from cte;