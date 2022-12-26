-- Question 196

-- Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- | 3  | john@example.com |
-- +----+------------------+

-- Id is the primary key column for this table.

-- For example, after running your query, the above Person table should have the following rows:
-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- +----+------------------+

/* CREATE TABLE Person (
  `Id` INTEGER,
  `Email` VARCHAR(16)
);

INSERT INTO Person
  ( `Id`, `Email`)
VALUES
  ('1', 'john@example.com'),
  ('2', 'bob@example.com'),
  ('3', 'john@example.com'); */

-- Solution
with cte as(
select *,
dense_rank() over(partition by Email order by Id) as 'rk'
from Person
)

delete from Person
where Id in (select Id from cte where rk>1);