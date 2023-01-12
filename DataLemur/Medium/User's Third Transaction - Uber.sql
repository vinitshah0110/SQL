/* User's Third Transaction [Uber SQL Interview Question]
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

Schema:
CREATE TABLE transactions (
  `user_id` INTEGER,
  `spend` FLOAT,
  `transaction_date` DATETIME
);

INSERT INTO transactions
  (`user_id`, `spend`, `transaction_date`)
VALUES
  ('111', '100.50', '2022/01/08 12:00:00'),
  ('111', '55.00', '2022/01/10 12:00:00'),
  ('121', '36.00', '2022/01/18 12:00:00'),
  ('145', '24.99', '2022/01/26 12:00:00'),
  ('111', '89.60', '2022/02/05 12:00:00');

Output:
user_id	spend	transaction_date
111	89.6	2022-02-05 12:00:00 */

-- Solution:
WITH cte AS(
 SELECT *,
 DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rk
 FROM transactions
)

SELECT user_id,	spend,	transaction_date
FROM cte 
WHERE rk=3;