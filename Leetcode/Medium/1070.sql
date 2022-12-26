-- Question 1070

-- Table: Sales
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- sale_id is the primary key of this table.
-- product_id is a foreign key to Product table.
-- Note that the price is per unit.

-- Table: Product
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key of this table.
 
-- Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+

-- Result table:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+

-- Schema:
/* CREATE TABLE Sales (
  `sale_id` INTEGER,
  `product_id` INTEGER,
  `year` INTEGER,
  `quantity` INTEGER,
  `price` INTEGER
);

INSERT INTO Sales
  (`sale_id`, `product_id`, `year`, `quantity`, `price`)
VALUES
  ('1', '100', '2008', '10', '5000'),
  ('2', '100', '2009', '12', '5000'),
  ('7', '200', '2011', '15', '9000'); */
  
-- Solution
WITH CTE AS(
  SELECT *,
  DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year) AS 'rk'
  FROM Sales
)

SELECT product_id, year AS 'first_year', quantity, price
FROM CTE
WHERE rk=1;