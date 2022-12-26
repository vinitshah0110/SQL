-- Question 175

-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | PersonId    | int     |
-- | FirstName   | varchar |
-- | LastName    | varchar |
-- +-------------+---------+
-- PersonId is the primary key column for this table.

-- Table: Address
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | AddressId   | int     |
-- | PersonId    | int     |
-- | City        | varchar |
-- | State       | varchar |
-- +-------------+---------+
-- AddressId is the primary key column for this table.
 

-- Write an SQL query to report the first name, last name, city, and state of each person in the Person table. 
-- If the address of a personId is not present in the Address table, report null instead.
-- Return the result table in any order.

-- Output: 
-- +-----------+----------+---------------+----------+
-- | firstName | lastName | city          | state    |
-- +-----------+----------+---------------+----------+
-- | Allen     | Wang     | Null          | Null     |
-- | Bob       | Alice    | New York City | New York |
-- +-----------+----------+---------------+----------+

-- Schema
/*
CREATE TABLE Person (
  `personId` INTEGER,
  `lastName` VARCHAR(5),
  `firstName` VARCHAR(5)
);

INSERT INTO Person
  (`personId`, `lastName`, `firstName`)
VALUES
  ('1', 'Wang', 'Allen'),
  ('2', 'Alice', 'Bob');

CREATE TABLE Address (
  `addressId` INTEGER,
  `personId` INTEGER,
  `city` VARCHAR(13),
  `state` VARCHAR(10)
);

INSERT INTO Address
  (`addressId`, `personId`, `city`, `state`)
VALUES
  ('1', '2', 'New York City', 'New York'),
  ('2', '3', 'Leetcode', 'California');
*/

-- Solution
select firstName, lastName, city, state
from Person left join Address
on Person.personId = Address.personId