-- Question 1179

-- Table: Department
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | revenue       | int     |
-- | month         | varchar |
-- +---------------+---------+
-- (id, month) is the primary key of this table.
-- The table has information about the revenue of each department per month.
-- The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 
-- Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.


-- Department table:
-- +------+---------+-------+
-- | id   | revenue | month |
-- +------+---------+-------+
-- | 1    | 8000    | Jan   |
-- | 2    | 9000    | Jan   |
-- | 3    | 10000   | Feb   |
-- | 1    | 7000    | Feb   |
-- | 1    | 6000    | Mar   |
-- +------+---------+-------+

-- Result table:
-- +------+-------------+-------------+-------------+-----+-------------+
-- | id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
-- +------+-------------+-------------+-------------+-----+-------------+
-- | 1    | 8000        | 7000        | 6000        | ... | null        |
-- | 2    | 9000        | null        | null        | ... | null        |
-- | 3    | null        | 10000       | null        | ... | null        |
-- +------+-------------+-------------+-------------+-----+-------------+

-- Schema:
/* CREATE TABLE Department (
  `id` INTEGER,
  `revenue` INTEGER,
  `month` VARCHAR(3)
);

INSERT INTO Department
  (`id`, `revenue`, `month`)
VALUES
  ('1', '8000', 'Jan'),
  ('2', '9000', 'Jan'),
  ('3', '10000', 'Feb'),
  ('1', '7000', 'Feb'),
  ('1', '6000', 'Mar'); */

-- Solution:
select id, 
max(case when month='Jan' then revenue else null end) as 'Jan_revenue',
max(case when month='Feb' then revenue else null end) as 'Feb_revenue',
max(case when month='Mar' then revenue else null end) as 'Mar_revenue'
from Department
group by id;