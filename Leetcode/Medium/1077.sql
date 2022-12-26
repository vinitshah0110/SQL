-- Question 1077

-- Table: Project
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | project_id  | int     |
-- | employee_id | int     |
-- +-------------+---------+
-- (project_id, employee_id) is the primary key of this table.
-- employee_id is a foreign key to Employee table.

-- Table: Employee
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | employee_id      | int     |
-- | name             | varchar |
-- | experience_years | int     |
-- +------------------+---------+
-- employee_id is the primary key of this table.
 
-- Write an SQL query that reports the most experienced employees in each project. 
-- In case of a tie, report all employees with the maximum number of experience years.

-- Project table:
-- +-------------+-------------+
-- | project_id  | employee_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- | 1           | 2           |
-- | 1           | 3           |
-- | 2           | 1           |
-- | 2           | 4           |
-- +-------------+-------------+

-- Employee table:
-- +-------------+--------+------------------+
-- | employee_id | name   | experience_years |
-- +-------------+--------+------------------+
-- | 1           | Khaled | 3                |
-- | 2           | Ali    | 2                |
-- | 3           | John   | 3                |
-- | 4           | Doe    | 2                |
-- +-------------+--------+------------------+

-- Result table:
-- +-------------+---------------+
-- | project_id  | employee_id   |
-- +-------------+---------------+
-- | 1           | 1             |
-- | 1           | 3             |
-- | 2           | 1             |
-- +-------------+---------------+
-- Both employees with id 1 and 3 have the 
-- most experience among the employees of the first project. For the second project, the employee with id 1 has the most experience.

-- Schema:
/* CREATE TABLE Project (
  `project_id` INTEGER,
  `employee_id` INTEGER
);

INSERT INTO Project
  (`project_id`, `employee_id`)
VALUES
  ('1', '1'),
  ('1', '2'),
  ('1', '3'),
  ('2', '1'),
  ('2', '4');

CREATE TABLE Employee (
  `employee_id` INTEGER,
  `name` VARCHAR(6),
  `experience_years` INTEGER
);

INSERT INTO Employee
  (`employee_id`, `name`, `experience_years`)
VALUES
  ('1', 'Khaled', '3'),
  ('2', 'Ali', '2'),
  ('3', 'John', '3'),
  ('4', 'Doe', '2'); */

-- Solution:
with cte as(
  select distinct project_id, Project.employee_id,
  dense_rank() over(partition by project_id order by experience_years desc) as 'rk'
  from Project join Employee
  on Project.employee_id = Employee.employee_id
)

select project_id, employee_id
from cte
where rk=1;