/* Frequently Purchased Pairs [Walmart SQL Interview Question]
Find the number of unique product combinations that are bought together (purchased in the same transaction).
For example, if I find two transactions where apples and bananas are bought, & another transaction where bananas and soy milk are bought
my output would be 2 to represent the 2 unique combinations. Your output should be a single number.

Schema:
CREATE TABLE transactions (
  `transaction_id` INTEGER,
  `product_id` INTEGER,
  `user_id` INTEGER
);

INSERT INTO transactions
  (`transaction_id`, `product_id`, `user_id`)
VALUES
  ('231574', '111', '234'),
  ('231574', '444', '234'),
  ('231574', '222', '234'),
  ('137124', '111', '125'),
  ('137124', '444', '125');

Output:
combo_num
4 */

-- Solution
SELECT COUNT(t1.product_id) AS combo_num
FROM transactions t1 JOIN transactions t2
ON t1.transaction_id = t2.transaction_id AND t1.user_id = t2.user_id AND t1.product_id < t2.product_id;