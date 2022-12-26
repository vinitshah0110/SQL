-- Question 183

-- Suppose that a website contains two tables, 
-- the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

-- Table: Customers
-- +----+-------+
-- | Id | Name  |
-- +----+-------+
-- | 1  | Joe   |
-- | 2  | Henry |
-- | 3  | Sam   |
-- | 4  | Max   |
-- +----+-------+

-- Table: Orders
-- +----+------------+
-- | Id | CustomerId |
-- +----+------------+
-- | 1  | 3          |
-- | 2  | 1          |
-- +----+------------+

-- Using the above tables as example, return the following:
-- +-----------+
-- | Customers |
-- +-----------+
-- | Henry     |
-- | Max       |
-- +-----------+

-- Schema
/* CREATE TABLE Customers (
  `--` VARCHAR(2),
  `Id` INTEGER,
  `Name` VARCHAR(5)
);

INSERT INTO Customers
  (`--`, `Id`, `Name`)
VALUES
  ('--', '1', 'Joe'),
  ('--', '2', 'Henry'),
  ('--', '3', 'Sam'),
  ('--', '4', 'Max');

CREATE TABLE Orders (
  `--` VARCHAR(2),
  `Id` INTEGER,
  `CustomerId` INTEGER
);

INSERT INTO Orders
  (`--`, `Id`, `CustomerId`)
VALUES
  ('--', '1', '3'),
  ('--', '2', '1'); */

-- Solution 1:
select Name as 'Customers'
from Customers left join Orders
on Customers.Id =  Orders.CustomerId
where Orders.CustomerId is null;

-- Solution 2:
select name as 'Customers' from Customers
where Id not in (select CustomerId from Orders);