/* 1972. First and Last Call On the Same Day

Write an SQL query to report the IDs of the user who had the first and the last call with the same person on any day.
Return the result table in any order.

Calls table:
+-----------+--------------+---------------------+
| caller_id | recipient_id | call_time           |
+-----------+--------------+---------------------+
| 8         | 4            | 2021-08-24 17:46:07 |
| 4         | 8            | 2021-08-24 19:57:13 |
| 5         | 1            | 2021-08-11 05:28:44 |
| 8         | 3            | 2021-08-17 04:04:15 |
| 11        | 3            | 2021-08-17 13:07:00 |
| 8         | 11           | 2021-08-17 22:22:22 |
+-----------+--------------+---------------------+

Result table:
+---------+
| user_id |
+---------+
| 1       |
| 4       |
| 5       |
| 8       |
+---------+
On 2021-08-24, the first and last call of this day for user 8 was with user 4. User 8 should be included in the answer.
Similary, User 4 had the first and last call on 2021-08-24 with user 8. User 4 should be included in the answer.
On 2021-08-11, user 1 and 5 had a call. The call was the only call for both of them on this day. Since this call is the first and last call of the day for both of them, they both should be included in the answr.

Schema:
CREATE TABLE Calls (
  `caller_id` INTEGER,
  `recipient_id` INTEGER,
  `call_time` DATETIME
);

INSERT INTO Calls
  (`caller_id`, `recipient_id`, `call_time`)
VALUES
  ('8', '4', '2021-08-24 17:46:07'),
  ('4', '8', '2021-08-24 19:57:13'),
  ('5', '1', '2021-08-11 05:28:44'),
  ('8', '3', '2021-08-17 04:04:15'),
  ('11', '3', '2021-08-17 13:07:00'),
  ('8', '11', '2021-08-17 22:22:22'); */

-- Solution:
with first_last_call as(
  select caller_id, recipient_id, call_time from Calls
  union all
  select recipient_id, caller_id, call_time from Calls
)

, call_log as(
  select *,
  dense_rank() over(partition by caller_id, date(call_time) order by call_time) as 'min_rank',
  dense_rank() over(partition by caller_id, date(call_time) order by call_time desc) as 'max_rank'
  from first_last_call
)

select caller_id 
from call_log
where min_rank=1 or max_rank=1
group by caller_id, date(call_time) having count(distinct recipient_id)=1;