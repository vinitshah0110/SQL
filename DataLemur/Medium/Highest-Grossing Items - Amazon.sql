/* Highest-Grossing Items [Amazon SQL Interview Question]
Assume you are given the table containing information on Amazon customers and their spending on products in various categories.
Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.

Schema:
CREATE TABLE product_spend (
  `category` VARCHAR(11),
  `product` VARCHAR(16),
  `user_id` INTEGER,
  `spend` FLOAT,
  `transaction_date` DATETIME
);

INSERT INTO product_spend
  (`category`, `product`, `user_id`, `spend`, `transaction_date`)
VALUES
  ('appliance', 'refrigerator', '165', '246.00', '2021/12/26 12:00:00'),
  ('appliance', 'refrigerator', '123', '299.99', '2022/03/02 12:00:00'),
  ('appliance', 'washing machine', '123', '219.80', '2022/03/02 12:00:00'),
  ('electronics', 'vacuum', '178', '152.00', '2022/04/05 12:00:00'),
  ('electronics', 'wireless headset', '156', '249.90', '2022/07/08 12:00:00'),
  ('electronics', 'vacuum', '145', '189.00', '2022/07/15 12:00:00');

Output:
category	product	total_spend
appliance	refrigerator	299.99
appliance	washing machine	219.80
electronics	vacuum	341.00
electronics	wireless headset	249.90 */

-- Solution:
WITH cte AS(
 SELECT category, product, SUM(spend) AS total_spend,
 DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS rk
 FROM product_spend
 WHERE EXTRACT(YEAR FROM transaction_date)=2022
 GROUP BY category, product
)

SELECT category, product, FORMAT(total_spend,2) AS total_spend
FROM cte 
WHERE rk<3;