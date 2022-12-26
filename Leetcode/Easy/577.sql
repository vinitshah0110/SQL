-- Question 577

-- Select all employee's name and bonus whose bonus is < 1000

-- Table: Employee
-- +-------+--------+-----------+--------+
-- | empId |  name  | supervisor| salary |
-- +-------+--------+-----------+--------+
-- |   1   | John   |  3        | 1000   |
-- |   2   | Dan    |  3        | 2000   |
-- |   3   | Brad   |  null     | 4000   |
-- |   4   | Thomas |  3        | 4000   |
-- +-------+--------+-----------+--------+
-- empId is the primary key column for this table.

-- Table: Bonus
-- +-------+-------+
-- | empId | bonus |
-- +-------+-------+
-- | 2     | 500   |
-- | 4     | 2000  |
-- +-------+-------+
-- empId is the primary key column for this table.

-- Example Ouput:
-- +-------+-------+
-- | name  | bonus |
-- +-------+-------+
-- | John  | null  |
-- | Dan   | 500   |
-- | Brad  | null  |
-- +-------+-------+

-- Schema:
/* CREATE TABLE Employee (
  `empId` INTEGER,
  `name` VARCHAR(6),
  `supervisor` VARCHAR(4),
  `salary` INTEGER
);

INSERT INTO Employee
  (`empId`, `name`, `supervisor`, `salary`)
VALUES
  ('1', 'John', '3', '1000'),
  ('2', 'Dan', '3', '2000'),
  ('3', 'Brad', 'null', '4000'),
  ('4', 'Thomas', '3', '4000');

CREATE TABLE Bonus (
  `empId` INTEGER,
  `bonus` INTEGER
);

INSERT INTO Bonus
  (`empId`, `bonus`)
VALUES
  ('2', '500'),
  ('4', '2000'); */

-- Solution:
select name, bonus from Employee
left join Bonus
on Employee.empId = Bonus.empId 
where bonus<1000 or bonus is null