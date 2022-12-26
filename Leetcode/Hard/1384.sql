-- Question 1384

-- Table: Product
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | product_name  | varchar |
-- +---------------+---------+
-- product_id is the primary key for this table.
-- product_name is the name of the product.
 
-- Table: Sales
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | product_id          | int     |
-- | period_start        | varchar |
-- | period_end          | date    |
-- | average_daily_sales | int     |
-- +---------------------+---------+
-- product_id is the primary key for this table. 
-- period_start and period_end indicates the start and end date for sales period, both dates are inclusive.
-- The average_daily_sales column holds the average daily sales amount of the items for the period.

-- Write an SQL query to report the Total sales amount of each item for each year, with corresponding product name, product_id, product_name and report_year.
-- Dates of the sales years are between 2018 to 2020. Return the result table ordered by product_id and report_year.

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 1          | LC Phone     |
-- | 2          | LC T-Shirt   |
-- | 3          | LC Keychain  |
-- +------------+--------------+

-- Sales table:
-- +------------+--------------+-------------+---------------------+
-- | product_id | period_start | period_end  | average_daily_sales |
-- +------------+--------------+-------------+---------------------+
-- | 1          | 2019-01-25   | 2019-02-28  | 100                 |
-- | 2          | 2018-12-01   | 2020-01-01  | 10                  |
-- | 3          | 2019-12-01   | 2020-01-31  | 1                   |
-- +------------+--------------+-------------+---------------------+

-- Result table:
-- +------------+--------------+-------------+--------------+
-- | product_id | product_name | report_year | total_amount |
-- +------------+--------------+-------------+--------------+
-- | 1          | LC Phone     |    2019     | 3500         |
-- | 2          | LC T-Shirt   |    2018     | 310          |
-- | 2          | LC T-Shirt   |    2019     | 3650         |
-- | 2          | LC T-Shirt   |    2020     | 10           |
-- | 3          | LC Keychain  |    2019     | 31           |
-- | 3          | LC Keychain  |    2020     | 31           |
-- +------------+--------------+-------------+--------------+
-- LC Phone was sold for the period of 2019-01-25 to 2019-02-28, and there are 35 days for this period. Total amount 35*100 = 3500. 
-- LC T-shirt was sold for the period of 2018-12-01 to 2020-01-01, and there are 31, 365, 1 days for years 2018, 2019 and 2020 respectively.
-- LC Keychain was sold for the period of 2019-12-01 to 2020-01-31, and there are 31, 31 days for years 2019 and 2020 respectively.

-- Schema:
/* CREATE TABLE Product (
  `product_id` INTEGER,
  `product_name` VARCHAR(11)
);

INSERT INTO Product
  (`product_id`, `product_name`)
VALUES
  ('1', 'LC Phone'),
  ('2', 'LC T-Shirt'),
  ('3', 'LC Keychain');

CREATE TABLE Sales (
  `product_id` INTEGER,
  `period_start` DATETIME,
  `period_end` DATETIME,
  `average_daily_sales` INTEGER
);

INSERT INTO Sales
  (`product_id`, `period_start`, `period_end`, `average_daily_sales`)
VALUES
  ('1', '2019-01-25', '2019-02-28', '100'),
  ('2', '2018-12-01', '2020-01-01', '10'),
  ('3', '2019-12-01', '2020-01-31', '1'); */

-- Solution
with master as(
  select product_id, product_name, '2018' as 'yr' from Product
  union all 
  select product_id, product_name, '2019' from Product
  union all
  select product_id, product_name, '2020' from Product
)

select master.product_id, product_name, yr as 'report_year', 
case
  when yr=year(period_start) and yr=year(period_end) then datediff(period_end,period_start)+1
  when yr>year(period_start) and yr<year(period_end) then 365
  when yr=year(period_end) then datediff(period_end,'2020-01-01')+1
  when yr=year(period_start) then datediff(date_format(period_start,'%Y-12-31'),period_start)+1
  else 0
end * average_daily_sales as 'total_amount'
from master left join Sales 
on master.product_id = Sales.product_id
order by 1;