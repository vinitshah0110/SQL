/* Sending vs. Opening Snaps [Snapchat SQL Interview Question]
Assume you are given the tables below containing information on Snapchat users, ages, and their time spent sending and opening snaps.
Write a query to obtain a breakdown of the time spent sending vs. opening snaps for each age group.
Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.

You should calculate these percentages:
time sending / (time sending + time opening)
time opening / (time sending + time opening)

Schema:
CREATE TABLE activities (
  `activity_id` INTEGER,
  `user_id` INTEGER,
  `activity_type` VARCHAR(4),
  `time_spent` FLOAT
);
INSERT INTO activities
  (`activity_id`, `user_id`, `activity_type`, `time_spent`)
VALUES
  ('7274', '123', 'open', '4.50'),
  ('2425', '123', 'send', '3.50'),
  ('1413', '456', 'send', '5.67'),
  ('1414', '789', 'chat', '11.00'),
  ('2536', '456', 'open', '3.00');

CREATE TABLE age_breakdown (
  `user_id` INTEGER,
  `age_bucket` VARCHAR(5)
);
INSERT INTO age_breakdown
  (`user_id`, `age_bucket`)
VALUES
  ('123', '31-35'),
  ('456', '26-30'),
  ('789', '21-25');
  
Output:
age_bucket	send_perc	open_perc
26-30	65.40	34.60
31-35	43.75	56.25 */

-- Solution:
SELECT age_breakdown.age_bucket,
FORMAT((SUM(CASE WHEN activity_type='send' THEN time_spent END)*1.0 / SUM(time_spent)*1.0)*100.0,2) AS send_perc,
FORMAT((SUM(CASE WHEN activity_type='open' THEN time_spent END)*1.0 / SUM(time_spent)*1.0)*100.0,2) AS open_perc
FROM activities JOIN age_breakdown
ON activities.user_id = age_breakdown.user_id
WHERE activity_type IN('open', 'send')
GROUP BY age_breakdown.age_bucket;