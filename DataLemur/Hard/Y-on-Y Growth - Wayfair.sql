/* Y-on-Y Growth Rate [Wayfair SQL Interview Question]
Write a query to obtain the year-on-year growth rate for the total spend of each product for each year.
Output the year (in ascending order) partitioned by product id, current year's spend, previous year's spend and year-on-year growth rate 
(percentage rounded to 2 decimal places).

Schema:
CREATE TABLE user_transactions (
  `transaction_id` INTEGER,
  `product_id` INTEGER,
  `spend` FLOAT,
  `transaction_date` DATETIME
);

INSERT INTO user_transactions
  (`transaction_id`, `product_id`, `spend`, `transaction_date`)
VALUES
  ('1341', '123424', '1500.60', '2019/12/31 12:00:00'),
  ('1423', '123424', '1000.20', '2020/12/31 12:00:00'),
  ('1623', '123424', '1246.44', '2021/12/31 12:00:00'),
  ('1322', '123424', '2145.32', '2022/12/31 12:00:00');

Output:
year	product_id	curr_year_spend	prev_year_spend	yoy_rate
2019	123424	1500.60		
2020	123424	1000.20	1500.60	-33.35
2021	123424	1246.44	1000.20	24.62
2022	123424	2145.32	1246.44	72.12 */

-- Solution:
WITH cte AS(
 SELECT EXTRACT(YEAR FROM transaction_date) AS year, product_id, spend AS curr_year_spend,
 LAG(spend,1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
 FROM user_transactions
)

SELECT year, product_id, curr_year_spend, prev_year_spend,
ROUND(100.0*(curr_year_spend - prev_year_spend) / prev_year_spend,2) AS yoy_rate
FROM cte;