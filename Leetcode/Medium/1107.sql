-- Question 1107

-- Table: Traffic
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | activity      | enum    |
-- | activity_date | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage'). 

-- Write an SQL query that reports for every date within at most 90 days from today, 
-- the number of users that logged in for the first time on that date. Assume today is 2019-06-30.

-- Traffic table:
-- +---------+----------+---------------+
-- | user_id | activity | activity_date |
-- +---------+----------+---------------+
-- | 1       | login    | 2019-05-01    |
-- | 1       | homepage | 2019-05-01    |
-- | 1       | logout   | 2019-05-01    |
-- | 2       | login    | 2019-06-21    |
-- | 2       | logout   | 2019-06-21    |
-- | 3       | login    | 2019-01-01    |
-- | 3       | jobs     | 2019-01-01    |
-- | 3       | logout   | 2019-01-01    |
-- | 4       | login    | 2019-06-21    |
-- | 4       | groups   | 2019-06-21    |
-- | 4       | logout   | 2019-06-21    |
-- | 5       | login    | 2019-03-01    |
-- | 5       | logout   | 2019-03-01    |
-- | 5       | login    | 2019-06-21    |
-- | 5       | logout   | 2019-06-21    |
-- +---------+----------+---------------+

-- Result table:
-- +------------+-------------+
-- | login_date | user_count  |
-- +------------+-------------+
-- | 2019-05-01 | 1           |
-- | 2019-06-21 | 2           |
-- +------------+-------------+
-- Note that we only care about dates with non zero user count.
-- The user with id 5 first logged in on 2019-03-01 so he's not counted on 2019-06-21.

-- Schema:
/* CREATE TABLE Traffic (
  `user_id` INTEGER,
  `activity` VARCHAR(8),
  `activity_date` DATE
);

INSERT INTO Traffic
  (`user_id`, `activity`, `activity_date`)
VALUES
  ('1', 'login', '2019-05-01'),
  ('1', 'homepage', '2019-05-01'),
  ('1', 'logout', '2019-05-01'),
  ('2', 'login', '2019-06-21'),
  ('2', 'logout', '2019-06-21'),
  ('3', 'login', '2019-01-01'),
  ('3', 'jobs', '2019-01-01'),
  ('3', 'logout', '2019-01-01'),
  ('4', 'login', '2019-06-21'),
  ('4', 'groups', '2019-06-21'),
  ('4', 'logout', '2019-06-21'),
  ('5', 'login', '2019-03-01'),
  ('5', 'logout', '2019-03-01'),
  ('5', 'login', '2019-06-21'),
  ('5', 'logout', '2019-06-21'); */

-- Solution:
set @today='2019-06-30';

with cte as(
  select *,
  min(activity_date) over(partition by user_id) as 'first_log'
  from Traffic
  where activity='login'
)

select first_log, count(distinct user_id) as 'user_count'
from cte
where first_log between date_add(@today, interval -90 day) and @today
group by first_log;