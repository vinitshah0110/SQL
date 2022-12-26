/* 2010: The Number of Seniors and Juniors to Join the Company

A company wants to hire new employees. The budget of the company for the salaries is $70000. The company’s criteria for hiring are:
Keep hiring the senior with the smallest salary until you cannot hire any more seniors.
Use the remaining budget to hire the junior with the smallest salary.
Keep hiring the junior with the smallest salary until you cannot hire any more juniors.

Write an SQL query to find the ids of seniors and juniors hired under the mentioned criteria.
Return the result table in any order.

Schema:
CREATE TABLE Candidates (
  `employee_id` INTEGER,
  `experience` VARCHAR(6),
  `salary` INTEGER
);

INSERT INTO Candidates
  (`employee_id`, `experience`, `salary`)
VALUES
  ('1', 'Junior', '10000'),
  ('9', 'Junior', '15000'),
  ('2', 'Senior', '20000'),
  ('11', 'Senior', '16000'),
  ('13', 'Senior', '50000'),
  ('4', 'Junior', '40000'); */

-- Output:
with budget as(
  select *,
  sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as 'cap'
  from Candidates
)

select employee_id
from budget where experience='Senior' and cap<=70000
union
select employee_id
from budget where experience='Junior' and cap<=70000-(select sum(salary) from budget where experience='Senior' and cap<=70000);