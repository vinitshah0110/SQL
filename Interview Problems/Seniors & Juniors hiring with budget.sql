/* A company wants to hire new employees. The budget of the company for the salaries is 70000. The company's criteria for hiring are:
Keep hiring the senior with the smallest salary until you can't hire more seniors
Use the remaining budget to hire the junior with the smallest salary
Keep hiring the junior with the smallest salary untill you can't hire more juniors

Write a sql query to find the seniors and juniors hired under the criteria

Schema:
create table candidates (
emp_id int,
experience varchar(20),
salary int
);

insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000); */

-- Solution:
with cte as(
  select *,
  sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as 'run_sal'
  from candidates
)

select emp_id, experience, salary
from cte where experience='Senior' and run_sal<=70000
union
select emp_id, experience, salary
from cte where experience='Junior' and run_sal<=70000-(select sum(salary) from cte where experience='Senior' and run_sal<=70000)
order by 1;