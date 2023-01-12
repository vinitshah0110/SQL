/* 1127 User Purchase Platform
Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile
and desktop together for each date.

Spending table:
+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+

Result table:
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+ 

Schema:
CREATE TABLE Spending (
  `user_id` INTEGER,
  `spend_date` DATE,
  `platform` VARCHAR(7),
  `amount` INTEGER
);

INSERT INTO Spending
  (`user_id`, `spend_date`, `platform`, `amount`)
VALUES
  ('1', '2019-07-01', 'mobile', '100'),
  ('1', '2019-07-01', 'desktop', '100'),
  ('2', '2019-07-01', 'mobile', '100'),
  ('2', '2019-07-02', 'mobile', '100'),
  ('3', '2019-07-01', 'desktop', '100'),
  ('3', '2019-07-02', 'desktop', '100'); */

-- Solution:
with cte as(
  select distinct spend_date, platform
  from Spending
  union all
  select distinct spend_date, 'both'
  from Spending
)

, count_platform as (
  select user_id, count(distinct platform) as 'cnt'
  from Spending
  group by user_id
)

, plat as(
  select Spending.user_id, spend_date, amount,
  case when cnt>1 then 'both' else platform end as 'platform'
  from Spending join count_platform
  on Spending.user_id = count_platform.user_id
)

select cte.spend_date, cte.platform, ifnull(sum(amount),0) as 'total_amount', count(distinct user_id) as 'total_users'
from cte left join plat
on cte.spend_date = plat.spend_date and cte.platform = plat.platform
group by cte.spend_date, cte.platform;
--order by 1, 4 desc, 3