-- Question 197

-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
-- +---------+------------------+------------------+
-- | Id(INT) | RecordDate(DATE) | Temperature(INT) |
-- +---------+------------------+------------------+
-- |       1 |       2015-01-01 |               10 |
-- |       2 |       2015-01-02 |               25 |
-- |       3 |       2015-01-03 |               20 |
-- |       4 |       2015-01-04 |               30 |
-- +---------+------------------+------------------+

-- Output table:
-- +----+
-- | Id |
-- +----+
-- |  2 |
-- |  4 |
-- +----+

-- Schema
/* CREATE TABLE Weather (
  `id` INTEGER,
  `recordDate` DATETIME,
  `temperature` INTEGER
);

INSERT INTO Weather
  (`id`, `recordDate`, `temperature`)
VALUES
  ('1', '2015-01-01', '10'),
  ('2', '2015-01-02', '25'),
  ('3', '2015-01-03', '20'),
  ('4', '2015-01-04', '30'); */

-- Solution 1:
with cte as(
  select *,
  lag(temperature) over(order by recordDate) as 'prev_temp'
  from Weather
)

select id 
from cte
where temperature > prev_temp;

-- Solution 2:
select w1.id
from Weather w1 join Weather w2
on w1.temperature > w2.temperature and datediff(w1.recordDate,w2.recordDate) = 1;