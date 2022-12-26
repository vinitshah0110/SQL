-- Question 1164

-- Table: Products
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
 
-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+

-- Result table:
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+

-- Schema:
/* CREATE TABLE Products (
  `product_id` INTEGER,
  `new_price` INTEGER,
  `change_date` DATE
);

INSERT INTO Products
  (`product_id`, `new_price`, `change_date`)
VALUES
  ('1', '20', '2019-08-14'),
  ('2', '50', '2019-08-14'),
  ('1', '30', '2019-08-15'),
  ('1', '35', '2019-08-16'),
  ('2', '65', '2019-08-17'),
  ('3', '20', '2019-08-18'); */

-- Solution:
with cte as(
  select *,
  dense_rank() over(partition by product_id order by change_date desc) as 'rk'
  from Products
  where change_date<='2019-08-16'
)

, master as(
  select distinct product_id from Products
)

select master.product_id, ifnull(new_price,10) as 'price'
from master left join cte
on master.product_id = cte.product_id and rk=1;