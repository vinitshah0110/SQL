/* Question 1767

Write an SQL query to report the IDs of the missing subtasks for each task_id.
Return the result table in any order.

Tasks table:
+---------+----------------+
| task_id | subtasks_count |
+---------+----------------+
| 1       | 3              |
| 2       | 2              |
| 3       | 4              |
+---------+----------------+

Executed table:
+---------+------------+
| task_id | subtask_id |
+---------+------------+
| 1       | 2          |
| 3       | 1          |
| 3       | 2          |
| 3       | 3          |
| 3       | 4          |
+---------+------------+

Result table:
+---------+------------+
| task_id | subtask_id |
+---------+------------+
| 1       | 1          |
| 1       | 3          |
| 2       | 1          |
| 2       | 2          |
+---------+------------+
Task 1 was divided into 3 subtasks (1, 2, 3). Only subtask 2 was executed successfully, so we include (1, 1) and (1, 3) in the answer.
Task 2 was divided into 2 subtasks (1, 2). No subtask was executed successfully, so we include (2, 1) and (2, 2) in the answer.
Task 3 was divided into 4 subtasks (1, 2, 3, 4). All of the subtasks were executed successfully.

Schema:
CREATE TABLE Tasks (
  `task_id` INTEGER,
  `subtasks_count` INTEGER
);

INSERT INTO Tasks
  (`task_id`, `subtasks_count`)
VALUES
  ('1', '3'),
  ('2', '2'),
  ('3', '4');

CREATE TABLE Executed (
  `task_id` INTEGER,
  `subtask_id` INTEGER
);

INSERT INTO Executed
  (`task_id`, `subtask_id`)
VALUES
  ('1', '2'),
  ('3', '1'),
  ('3', '2'),
  ('3', '3'),
  ('3', '4'); */

-- Solution:
with recursive cte as(
  select 1 as subtask
  union all
  select subtask+1 from cte
  where subtask < (select max(subtasks_count) from Tasks)
)

, sub as(
  select * from Tasks join cte
  on subtask<=subtasks_count
)

select sub.task_id, subtask
from sub left join Executed
on sub.task_id = Executed.task_id and subtask = subtask_id
where subtask_id is null
order by 1;