/* Mean, Median, Mode [Microsoft SQL Interview Question]
Output the median, median and mode (in this order). 
Round the mean to the the closest integer and assume that there are no ties for mode.

Schema:
CREATE TABLE inbox_stats (
  `user_id` INTEGER,
  `email_count` INTEGER
);

INSERT INTO inbox_stats
  (`user_id`, `email_count`)
VALUES
  ('123', '100'),
  ('234', '200'),
  ('345', '300'),
  ('456', '200'),
  ('567', '200');

Output:
mean	median	mode
200	200	200 */

-- Solution:
WITH mode_val AS(
 SELECT email_count AS mode,
 DENSE_RANK() OVER(ORDER BY COUNT(user_id) DESC) AS rk
 FROM inbox_stats
 GROUP BY email_count
)

, mean_val AS(
 SELECT DISTINCT ROUND(AVG(email_count) OVER()) AS mean, 1 AS counter
 FROM inbox_stats
)

, median_val AS(
 SELECT email_count,
 COUNT(user_id) OVER() AS cnt,
 ROW_NUMBER() OVER(ORDER BY email_count) AS rw
 FROM inbox_stats
)

, med AS(
 SELECT ROUND(AVG(email_count)) AS median, 1 AS counter
 FROM median_val
 WHERE rw BETWEEN cnt/2 AND (cnt/2)+1
)

SELECT mean, median, mode
FROM mean_val JOIN med
ON mean_val.counter = med.counter
JOIN mode_val
ON mean_val.counter = mode_val.rk;