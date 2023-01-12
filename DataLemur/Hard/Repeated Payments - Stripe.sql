/* Repeated Payments [Stripe SQL Interview Question]
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a 
credit card to be charged twice.
Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount
within 10 minutes of each other. Count such repeated payments.

Schema:
CREATE TABLE transactions (
  `transaction_id` INTEGER,
  `merchant_id` INTEGER,
  `credit_card_id` INTEGER,
  `amount` INTEGER,
  `transaction_timestamp` DATETIME
);

INSERT INTO transactions
  (`transaction_id`, `merchant_id`, `credit_card_id`, `amount`, `transaction_timestamp`)
VALUES
  ('1', '101', '1', '100', '2022/09/25 12:00:00'),
  ('2', '101', '1', '100', '2022/09/25 12:08:00'),
  ('3', '101', '1', '100', '2022/09/25 12:28:00'),
  ('4', '102', '2', '300', '2022/09/25 12:00:00'),
  ('6', '102', '2', '400', '2022/09/25 14:00:00');

Output:
payment_count
1 */

-- Solution:
SELECT count(*) AS payment_count
FROM transactions t1 JOIN transactions t2
ON t1.merchant_id = t2.merchant_id AND t1.credit_card_id = t2.credit_card_id AND t1.amount = t2.amount AND 
t1.transaction_timestamp > t2.transaction_timestamp 
AND TIME_TO_SEC(TIMEDIFF(t1.transaction_timestamp, t2.transaction_timestamp))<601;