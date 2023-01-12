/* Average Review Ratings [Amazon SQL Interview Question]
Given the reviews table, write a query to get the average stars for each product every month.
The output should include the month in numerical value, product id, and average star rating rounded to two decimal places. 
Sort the output based on month followed by the product id.

Schema:
CREATE TABLE reviews (
  `review_id` INTEGER,
  `user_id` INTEGER,
  `submit_date` DATETIME,
  `product_id` INTEGER,
  `stars` INTEGER
);

INSERT INTO reviews
  (`review_id`, `user_id`, `submit_date`, `product_id`, `stars`)
VALUES
  ('6171', '123', '2022/06/08 00:00:00', '50001', '4'),
  ('7802', '265', '2022/06/10 00:00:00', '69852', '4'),
  ('5293', '362', '2022/06/18 00:00:00', '50001', '3'),
  ('6352', '192', '2022/07/26 00:00:00', '69852', '3'),
  ('4517', '981', '2022/07/05 00:00:00', '69852', '2');

Output:
mth	product	avg_stars
6	50001	3.50
6	69852	4.00
7	69852	2.50 */

-- Solution:
SELECT DISTINCT EXTRACT(MONTH FROM submit_date) AS mth, product_id,
ROUND(AVG(stars) OVER(PARTITION BY EXTRACT(MONTH FROM submit_date), product_id),2) AS avg_stars
FROM reviews
ORDER BY mth, product_id;