/* Cities With Completed Trades [Robinhood SQL Interview Question]
You are given the tables below containing information on Robinhood trades and users. 
Write a query to list the top three cities that have the most completed trade orders in descending order.

Schema:
CREATE TABLE trades (
  `order_id` INTEGER,
  `user_id` INTEGER,
  `price` FLOAT,
  `quantity` INTEGER,
  `status` VARCHAR(9)
);

INSERT INTO trades
  (`order_id`, `user_id`, `price`, `quantity`, `status`)
VALUES
  ('100101', '111', '9.80', '10', 'Cancelled'),
  ('100102', '111', '10.00', '10', 'Completed'),
  ('100259', '148', '5.10', '35', 'Completed'),
  ('100264', '148', '4.80', '40', 'Completed'),
  ('100305', '300', '10.00', '15', 'Completed'),
  ('100400', '178', '9.90', '15', 'Completed'),
  ('100565', '265', '25.60', '5', 'Completed');

CREATE TABLE users (
  `user_id` INTEGER,
  `city` VARCHAR(13),
  `email` VARCHAR(29),
  `signup_date` DATETIME
);

INSERT INTO users
  (`user_id`, `city`, `email`)
VALUES
  ('111', 'San Francisco', 'rrok10@gmail.com'),
  ('148', 'Boston', 'sailor9820@gmail.com'),
  ('178', 'San Francisco', 'harrypotterfan182@gmail.com'),
  ('265', 'Denver', 'shadower_@hotmail.com'),
  ('300', 'San Francisco', 'houstoncowboy1122@hotmail.com');

Output:
city	total_orders
San Francisco	3
Boston	2
Denver	1 */

-- Solution 1:
SELECT users.city, COUNT(trades.order_id) AS total_orders
FROM users JOIN trades
ON users.user_id = trades.user_id AND trades.status='Completed'
GROUP BY users.city
ORDER BY total_orders DESC
LIMIT 3;

-- Solution 2:
WITH cte as(
 SELECT users.city, COUNT(trades.order_id) AS total_orders,
 DENSE_RANK() OVER(ORDER BY COUNT(trades.order_id) DESC) AS rk
 FROM users JOIN trades
 ON users.user_id = trades.user_id AND trades.status='Completed'
 GROUP BY users.city
)

SELECT city, total_orders
from cte
WHERE rk<4;