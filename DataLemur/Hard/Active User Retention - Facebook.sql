/* Active User Retention [Facebook SQL Interview Question] 
Write a query to obtain the active user retention in July 2022. Output the month and the number of monthly active users (MAUs).
An active user is a user who has user action ("sign-in", "like", or "comment") in the current month and last month.

Schema:
CREATE TABLE user_actions (
  `user_id` INTEGER,
  `event_id` INTEGER,
  `event_type` VARCHAR(7),
  `event_date` DATETIME
);

INSERT INTO user_actions
  (`user_id`, `event_id`, `event_type`, `event_date`)
VALUES
  ('445', '7765', 'sign-in', '2022/05/31 12:00:00'),
  ('742', '6458', 'sign-in', '2022/06/03 12:00:00'),
  ('445', '3634', 'like', '2022/06/05 12:00:00'),
  ('742', '1374', 'comment', '2022/06/05 12:00:00'),
  ('648', '3124', 'like', '2022/06/18 12:00:00');

Output:
month	monthly_active_users
6	1 
Note: We are showing you output for June 2022 as the user_actions table only have event_dates in June 2022. 
You should work out the solution for July 2022.*/

-- Solution:
SELECT 7 AS month, COUNT(DISTINCT u1.user_id) AS monthly_active_users
FROM user_actions u1 JOIN user_actions u2
ON u1.user_id = u2.user_id
AND EXTRACT(MONTH FROM u1.event_date) = 07 AND EXTRACT(MONTH FROM u2.event_date) = 06
AND u1.event_type IN('sign-in', 'like', 'comment') AND u2.event_type IN('sign-in', 'like', 'comment');