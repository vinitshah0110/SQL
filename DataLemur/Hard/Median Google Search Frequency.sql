/* Median Google Search Frequency [Google SQL Interview Question]
Write a query to report the median of searches made by a user. Round the median to one decimal point.

Schema:
CREATE TABLE search_frequency (
  `searches` INTEGER,
  `num_users` INTEGER
);

INSERT INTO search_frequency
  (`searches`, `num_users`)
VALUES
  ('1', '2'),
  ('2', '2'),
  ('3', '3'),
  ('4', '1');

Output:
median
2.5 */

-- Solution:
WITH cte AS(
 SELECT *,
 SUM(num_users) OVER(ORDER BY searches) - num_users AS start_flag,
 SUM(num_users) OVER(ORDER BY searches) AS end_flag,
 SUM(num_users) OVER() AS total_users
 FROM search_frequency
)

SELECT ROUND(AVG(searches),1) AS median
FROM cte
WHERE total_users/2.0 BETWEEN start_flag AND end_flag;