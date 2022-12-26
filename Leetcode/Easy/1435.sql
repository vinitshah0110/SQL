-- Question 1435

-- Table: Sessions
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | session_id          | int     |
-- | duration            | int     |
-- +---------------------+---------+
-- session_id is the primary key for this table.
-- duration is the time in seconds that a user has visited the application.
 

-- You want to know how long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>" and "15 minutes or more" and count the number of sessions on it.
-- Write an SQL query to report the (bin, total) in any order.

-- Sessions table:
-- +-------------+---------------+
-- | session_id  | duration      |
-- +-------------+---------------+
-- | 1           | 30            |
-- | 2           | 199           |
-- | 3           | 299           |
-- | 4           | 580           |
-- | 5           | 1000          |
-- +-------------+---------------+

-- Result table:
-- +--------------+--------------+
-- | bin          | total        |
-- +--------------+--------------+
-- | [0-5>        | 3            |
-- | [5-10>       | 1            |
-- | [10-15>      | 0            |
-- | 15 or more   | 1            |
-- +--------------+--------------+

-- For session_id 1, 2 and 3 have a duration greater or equal than 0 minutes and less than 5 minutes.
-- For session_id 4 has a duration greater or equal than 5 minutes and less than 10 minutes.
-- There are no session with a duration greater or equial than 10 minutes and less than 15 minutes.
-- For session_id 5 has a duration greater or equal than 15 minutes.

-- Schema
/* CREATE TABLE Sessions (
  `session_id` INTEGER,
  `duration` INTEGER
);

INSERT INTO Sessions
  (`session_id`, `duration`)
VALUES
  ('1', '30'),
  ('2', '199'),
  ('3', '299'),
  ('4', '580'),
  ('5', '1000'); */

-- Solution 1
with cte as(
  select *,(duration/60),
  case
     when (duration/60) between 0 and 5 then '[0-5>'
     when (duration/60) between 5 and 10 then '[5-10>'
  	 when (duration/60) between 10 and 15 then '[10-15>'
     else '15 or more'
  end as 'bin'
  from Sessions
)

, master_cte as(
select '[0-5>' as 'bin' union select '[5-10>' union select '[10-15>' union select '15 or more'
)

select master_cte.bin, ifnull(temp.total,0) as 'total' from master_cte
left join
(select bin, count(1) as 'total' from cte group by bin) temp
on master_cte.bin = temp.bin

-- Solution 2
select 
'[0-5>' as 'bin', sum(case when (duration/60) between 0 and 5 then 1 else 0 end) as 'total' 
from Sessions
  union
select '[5-10>', sum(case when (duration/60) between 5 and 10 then 1 else 0 end) from Sessions
  union
select '[10-15>', sum(case when (duration/60) between 10 and 15 then 1 else 0 end) from Sessions
  union
select '15 or more', sum(case when (duration/60)>14 then 1 else 0 end) from Sessions