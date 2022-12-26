-- Question 180

-- Write a SQL query to find all numbers that appear at least three times consecutively.
-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+

-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

-- Schema:
/* CREATE TABLE logs (
  `Id` INTEGER,
  `Num` INTEGER
);

INSERT INTO logs
  (`Id`, `Num`)
VALUES
  ('1', '1'),
  ('2', '1'),
  ('3', '1'),
  ('4', '2'),
  ('5', '1'),
  ('6', '2'),
  ('7', '2'); */

-- Solution
with cte as (
  select Num,
  lag(Num,1) over(order by id) 'prev',
  lead(Num,1) over(order by id) 'nxt'
  from logs
)

select distinct Num
from cte
where Num = nxt and Num = prev;