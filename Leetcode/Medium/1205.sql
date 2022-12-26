-- Question 1205

-- Table: Transactions
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].

-- Table: Chargebacks
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | charge_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
 
-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+

-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+

-- Schema:
/* CREATE TABLE Transactions (
  `id` INTEGER,
  `country` VARCHAR(2),
  `state` VARCHAR(8),
  `amount` INTEGER,
  `trans_date` DATE
);

INSERT INTO Transactions
  (`id`, `country`, `state`, `amount`, `trans_date`)
VALUES
  ('101', 'US', 'approved', '1000', '2019-05-18'),
  ('102', 'US', 'declined', '2000', '2019-05-19'),
  ('103', 'US', 'approved', '3000', '2019-06-10'),
  ('104', 'US', 'approved', '4000', '2019-06-13'),
  ('105', 'US', 'approved', '5000', '2019-06-15');

CREATE TABLE Chargebacks (
  `trans_id` INTEGER,
  `trans_date` DATETIME
);

INSERT INTO Chargebacks
  (`trans_id`, `trans_date`)
VALUES
  ('102', '2019-05-29'),
  ('101', '2019-06-30'),
  ('105', '2019-09-18'); */

-- Solution
with approve as(
  select left(trans_date,7) as 'month', country, 
  count(id) as 'approved_count', sum(amount) as 'approved_amount'
  from Transactions
  where state='approved'
  group by left(trans_date,7), country
)

, charge as(
  select left(Chargebacks.trans_date,7) as 'month', 
  count(trans_id) as 'chargeback_count', sum(amount) as 'chargeback_amount'
  from Chargebacks join Transactions
  on trans_id = id
  group by left(trans_date,7)
)
-- use full outerjoin