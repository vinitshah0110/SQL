/* 2474. Customers With Strictly Increasing Purchases

Write an SQL query to report the IDs of the customers with thetotal purchasesstrictly increasing yearly.
The total purchases of a customer in one year is the sum of the prices of their orders in that year. 
If for some year the customer did not make any order, we consider the total purchases 0.
The first year to consider for each customer is the year of their first order. The last year to consider for each customer is the year of their last order.
Return the result tablein any order.

Orders table:
+----------+-------------+------------+-------+
| order_id | customer_id | order_date | price |
+----------+-------------+------------+-------+
| 1        | 1           | 2019-07-01 |  1100 |
| 2        | 1           | 2019-11-01 |  1200 |
| 3        | 1           | 2020-05-26 |  3000 |
| 4        | 1           | 2021-08-31 |  3100 |
| 5        | 1           | 2022-12-07 |  4700 |
| 6        | 2           | 2015-01-01 |  700  |
| 7        | 2           | 2017-11-07 |  1000 |
| 8        | 3           | 2017-01-01 |  900  |
| 9        | 3           | 2018-11-07 |  900  |
+----------+-------------+------------+-------+

Output:
+-------------+
| customer_id |
+-------------+
|1            |
+-------------+
Customer 1: The first year is 2019 and the last year is 2022 - 2019: 1100 + 1200 = 2300 - 2020: 3000 - 2021: 3100 - 2022: 4700 We can see that the total purchases are strictly increasing yearly, so we include customer 1 in the answer.
Customer 2: The first year is 2015 and the last year is 2017 - 2015: 700 - 2016: 0 - 2017: 1000 We do not include customer 2 in the answer because the total purchases are not strictly increasing. Note that customer 2 did not make any purchases in 2016.
Customer 3: The first year is 2017, and the last year is 2018 - 2017: 900 - 2018: 900 We can see that the total purchases are strictly increasing yearly, so we include customer 1 in the answer.

Schema:
CREATE TABLE Orders (
  `order_id` INTEGER,
  `customer_id` INTEGER,
  `order_date` DATE,
  `price` INTEGER
);

INSERT INTO Orders
  (`order_id`, `customer_id`, `order_date`, `price`)
VALUES
  ('1', '1', '2019-07-01', '1100'),
  ('2', '1', '2019-11-01', '1200'),
  ('3', '1', '2020-05-26', '3000'),
  ('4', '1', '2021-08-31', '3100'),
  ('5', '1', '2022-12-07', '4700'),
  ('6', '2', '2015-01-01', '700'),
  ('7', '2', '2017-11-07', '1000'),
  ('8', '3', '2017-01-01', '900'),
  ('9', '3', '2018-11-07', '900'); */

-- Solution:
with cte as(
  select customer_id, year(order_date) as 'yr',
  sum(price) over(partition by customer_id, year(order_date)) as 'price'
  from Orders
)

, rank_cus as(
  select customer_id, yr,
  dense_rank() over(partition by customer_id order by price) as 'rk'
  from cte
)

select customer_id
from rank_cus
group by customer_id
having count(distinct yr-rk)=1;