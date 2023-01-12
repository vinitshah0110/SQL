/* Tweets' Rolling Averages [Twitter SQL Interview Question]
The table below contains information about tweets over a given period of time. 
Calculate the 3-day rolling average of tweets published by each user for each date that a tweet was posted. 
Output the user id, tweet date, and rolling averages rounded to 2 decimal places.

Schema:
CREATE TABLE tweets (
  `tweet_id` INTEGER,
  `user_id` INTEGER,
  `tweet_date` DATETIME
);

INSERT INTO tweets
  (`tweet_id`, `user_id`, `tweet_date`)
VALUES
  ('214252', '111', '2022/06/01 12:00:00'),
  ('739252', '111', '2022/06/01 12:00:00'),
  ('846402', '111', '2022/06/02 12:00:00'),
  ('241425', '254', '2022/06/02 12:00:00'),
  ('137374', '111', '2022/06/04 12:00:00');

Output:
user_id	tweet_date	rolling_avg_3days
111	2022-06-01 12:00:00	2.00
111	2022-06-02 12:00:00	1.50
111	2022-06-04 12:00:00	1.33
254	2022-06-02 12:00:00	1.00 */

-- Solution:
WITH cte AS(
 SELECT user_id, tweet_date, COUNT(tweet_id) AS cnt
 FROM tweets
 GROUP BY user_id, tweet_date
)

SELECT user_id,	tweet_date,
ROUND(AVG(cnt) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3days
FROM cte;