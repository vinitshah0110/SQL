-- Question 1225

-- Table: Failed
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | fail_date    | date    |
-- +--------------+---------+
-- Primary key for this table is fail_date.
-- Failed table contains the days of failed tasks.

-- Table: Succeeded
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | success_date | date    |
-- +--------------+---------+
-- Primary key for this table is success_date.
-- Succeeded table contains the days of succeeded tasks.
 
-- A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.
-- Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.
-- period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded.
-- Order result by start_date.

-- Failed table:
-- +-------------------+
-- | fail_date         |
-- +-------------------+
-- | 2018-12-28        |
-- | 2018-12-29        |
-- | 2019-01-04        |
-- | 2019-01-05        |
-- +-------------------+

-- Succeeded table:
-- +-------------------+
-- | success_date      |
-- +-------------------+
-- | 2018-12-30        |
-- | 2018-12-31        |
-- | 2019-01-01        |
-- | 2019-01-02        |
-- | 2019-01-03        |
-- | 2019-01-06        |
-- +-------------------+

-- Result table:
-- +--------------+--------------+--------------+
-- | period_state | start_date   | end_date     |
-- +--------------+--------------+--------------+
-- | succeeded    | 2019-01-01   | 2019-01-03   |
-- | failed       | 2019-01-04   | 2019-01-05   |
-- | succeeded    | 2019-01-06   | 2019-01-06   |
-- +--------------+--------------+--------------+
-- The report ignored the system state in 2018 as we care about the system in the period 2019-01-01 to 2019-12-31.
-- From 2019-01-01 to 2019-01-03 all tasks succeeded and the system state was "succeeded".
-- From 2019-01-04 to 2019-01-05 all tasks failed and system state was "failed".
-- From 2019-01-06 to 2019-01-06 all tasks succeeded and system state was "succeeded".

-- Schema:
/* CREATE TABLE Failed (
  `fail_date` DATE
);

INSERT INTO Failed
  (`fail_date`)
VALUES
  ('2018-12-28'),
  ('2018-12-29'),
  ('2019-01-04'),
  ('2019-01-05');

CREATE TABLE Succeeded (
  `success_date` DATE
);

INSERT INTO Succeeded
  (`success_date`)
VALUES
  ('2018-12-30'),
  ('2018-12-31'),
  ('2019-01-01'),
  ('2019-01-02'),
  ('2019-01-03'),
  ('2019-01-06'); */

-- Solution
with success as(
  select *, 'succeeded' as 'period_state',
  day(success_date) - row_number() over(partition by month(success_date) order by day(success_date)) as 'gap'
  from Succeeded
  where year(success_date)=2019
)

, fail as(
  select *, 'failed' as 'period_state',
  day(fail_date) - row_number() over(partition by month(fail_date) order by day(fail_date)) as 'gap'
  from Failed
  where year(fail_date)=2019
)

select period_state, min(success_date) as 'start_date', max(success_date) as 'end_date'
from success group by period_state, month(success_date), gap
union
select period_state, min(fail_date) as 'start_date', max(fail_date) as 'end_date'
from fail group by period_state, month(fail_date), gap
order by 2;