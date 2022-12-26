-- Question 1398

-- Table: Customers
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | customer_id         | int     |
-- | customer_name       | varchar |
-- +---------------------+---------+
-- customer_id is the primary key for this table.
-- customer_name is the name of the customer.

-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | customer_id   | int     |
-- | product_name  | varchar |
-- +---------------+---------+
-- order_id is the primary key for this table.
-- customer_id is the id of the customer who bought the product "product_name".
 
-- Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them buy this product.
-- Return the result table ordered by customer_id.

-- Customers table:
-- +-------------+---------------+
-- | customer_id | customer_name |
-- +-------------+---------------+
-- | 1           | Daniel        |
-- | 2           | Diana         |
-- | 3           | Elizabeth     |
-- | 4           | Jhon          |
-- +-------------+---------------+

-- Orders table:
-- +------------+--------------+---------------+
-- | order_id   | customer_id  | product_name  |
-- +------------+--------------+---------------+
-- | 10         |     1        |     A         |
-- | 20         |     1        |     B         |
-- | 30         |     1        |     D         |
-- | 40         |     1        |     C         |
-- | 50         |     2        |     A         |
-- | 60         |     3        |     A         |
-- | 70         |     3        |     B         |
-- | 80         |     3        |     D         |
-- | 90         |     4        |     C         |
-- +------------+--------------+---------------+

-- Result table:
-- +-------------+---------------+
-- | customer_id | customer_name |
-- +-------------+---------------+
-- | 3           | Elizabeth     |
-- +-------------+---------------+
-- Only the customer_id with id 3 bought the product A and B but not the product C.

-- Schema:
/* CREATE TABLE Customers (
  `customer_id` INTEGER,
  `customer_name` VARCHAR(9)
);

INSERT INTO Customers
  (`customer_id`, `customer_name`)
VALUES
  ('1', 'Daniel'),
  ('2', 'Diana'),
  ('3', 'Elizabeth'),
  ('4', 'Jhon');

CREATE TABLE Orders (
  `order_id` INTEGER,
  `customer_id` INTEGER,
  `product_name` VARCHAR(1)
);

INSERT INTO Orders
  (`order_id`, `customer_id`, `product_name`)
VALUES
  ('10', '1', 'A'),
  ('20', '1', 'B'),
  ('30', '1', 'D'),
  ('40', '1', 'C'),
  ('50', '2', 'A'),
  ('60', '3', 'A'),
  ('70', '3', 'B'),
  ('80', '3', 'D'),
  ('90', '4', 'C'); */

-- Solution:
select Orders.customer_id, customer_name
from Orders join Customers
on Orders.customer_id = Customers.customer_id
where product_name in ('a', 'b' ,'c')
group by Orders.customer_id, customer_name
having max(product_name) = 'b' and min(product_name) = 'a';