/* Odd and Even Measurements [Google SQL Interview Question]
Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns.
Refer to the Example Output below for the output format.
1st, 3rd, and 5th measurements taken within a day are considered odd-numbered measurements and the 2nd, 4th, and 6th measurements are
even-numbered measurements.

Schema:
CREATE TABLE measurements (
  `measurement_id` INTEGER,
  `measurement_value` FLOAT,
  `measurement_time` DATETIME
);

INSERT INTO measurements
  (`measurement_id`, `measurement_value`, `measurement_time`)
VALUES
  ('131233', '1109.51', '2022/07/10 09:00:00'),
  ('135211', '1662.74', '2022/07/10 11:00:00'),
  ('523542', '1246.24', '2022/07/10 13:15:00'),
  ('143562', '1124.50', '2022/07/11 15:00:00'),
  ('346462', '1234.14', '2022/07/11 16:45:00');

Output:
measurement_day	odd_sum	even_sum
07/10/2022 00:00:00	2355.75	1662.74
07/11/2022 00:00:00	1124.50	1234.14 */

-- Solution:
WITH cte AS(
 SELECT DATE(measurement_time) AS measurement_day, measurement_value,
 DENSE_RANK() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time) AS rk
 FROM measurements
)

SELECT measurement_day,
SUM(CASE WHEN rk IN(1,3,5) THEN measurement_value END) AS odd_sum,
SUM(CASE WHEN rk IN(2,4,6) THEN measurement_value END) AS even_sum
FROM cte
GROUP BY measurement_day;