-- Question 184

-- The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.
-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+

-- The Department table holds all departments of the company.
-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+

-- Write a SQL query to find employees who have the highest salary in each of the departments. 
-- For the above tables, your SQL query should return the following rows (order of rows does not matter).
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- +------------+----------+--------+
-- Explanation:
-- Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

-- Schema:
/* CREATE TABLE Employee (
  `Id` INTEGER,
  `Name` VARCHAR(5),
  `Salary` INTEGER,
  `DepartmentId` INTEGER
);

INSERT INTO Employee
  (`Id`, `Name`, `Salary`, `DepartmentId`)
VALUES
  ('1', 'Joe', '70000', '1'),
  ('2', 'Jim', '90000', '1'),
  ('3', 'Henry', '80000', '2'),
  ('4', 'Sam', '60000', '2'),
  ('5', 'Max', '90000', '1');

CREATE TABLE Department (
  `Id` INTEGER,
  `Name` VARCHAR(5)
);

INSERT INTO Department
  (`Id`, `Name`)
VALUES
  ('1', 'IT'),
  ('2', 'Sales'); */

-- Solution:
with cte as(
  select Department.Name as 'Department', Employee.Name as 'Employee', Salary,
  max(Salary) over(partition by DepartmentId) as 'dept_max'
  from Employee join Department
  on DepartmentId = Department.Id
)

select Department, Employee, Salary
from cte
where Salary = dept_max;