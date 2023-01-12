/* Histogram of Users and Purchases [Walmart SQL Interview Question]
Based on a user's most recent transaction date, write a query to obtain the users and the number of products bought.
Output the user's most recent transaction date, user ID & the number of products sorted by the transaction date in chronological order.

Schema:
CREATE TABLE user_transactions (
  `product_id` INTEGER,
  `user_id` INTEGER,
  `spend` FLOAT,
  `transaction_date` DATETIME
);

INSERT INTO user_transactions
  (`product_id`, `user_id`, `spend`, `transaction_date`)
VALUES
  ('3673', '123', '68.90', '2022/07/08 12:00:00'),
  ('9623', '123', '274.10', '2022/07/08 12:00:00'),
  ('1467', '115', '19.90', '2022/07/08 12:00:00'),
  ('2513', '159', '25.00', '2022/07/08 12:00:00'),
  ('1452', '159', '74.50', '2022/07/10 12:00:00');

Output:
transaction_date	user_id	purchase_count
2022-07-08 12:00:00	115	1
2022-07-08 12:00:00	123	2
2022-07-10 12:00:00	159	1 */

-- Solution:
WITH cte AS(
 SELECT transaction_date, user_id,
 COUNT(product_id) OVER(PARTITION BY user_id, transaction_date) AS purchase_count,
 DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS rk
 FROM user_transactions
)

SELECT DISTINCT transaction_date, user_id, purchase_count
FROM cte
WHERE rk=1
ORDER BY 1;