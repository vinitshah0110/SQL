/* 2004: The Number of Seniors and Juniors to Join the Company

A company wants to hire new employees. The budget of the company for the salaries is $70000. The company’s criteria for hiring are:
Hiring the largest number of seniors.
After hiring the maximum number of seniors, use the remaining budget to hire the largest number of juniors.
Write an SQL query to find the number of seniors and juniors hired under the mentioned criteria.

Return the result table in any order. 

Input table:
employee_id	experience	salary
1	Junior	10000
9	Junior	10000
2	Senior	20000
11	Senior	20000
13	Senior	50000
4	Junior	40000

Output table:
experience	accepted_candidates
Senior	2
Junior	2

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
  ('9', 'Junior', '10000'),
  ('2', 'Senior', '20000'),
  ('11', 'Senior', '20000'),
  ('13', 'Senior', '50000'),
  ('4', 'Junior', '40000'); */

-- Solution:
with budget as(
  select *,
  sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as 'cap'
  from Candidates
)

select 'Senior' as 'experience', count(1) as 'accepted_candidates'
from budget
where experience='Senior' and cap<=70000
  union
select 'Junior', count(1)
from budget
where experience='Junior' and cap<=70000-(select ifnull(sum(salary),0) from budget where experience='Senior' and cap<=70000);