--Question 1454

-- Table Accounts:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.
 
-- Table Logins:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

-- Write an SQL query to find the id and the name of active users.
-- Active users are those who logged in to their accounts for 5 or more consecutive days.
-- Return the result table ordered by the id.

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

-- Schema:
/* CREATE TABLE Accounts (
  `id` INTEGER,
  `name` VARCHAR(8)
);

INSERT INTO Accounts
  (`id`, `name`)
VALUES
  ('1', 'Winston'),
  ('7', 'Jonathan');

CREATE TABLE Logins (
  `id` INTEGER,
  `login_date` DATETIME
);

INSERT INTO Logins
  (`id`, `login_date`)
VALUES
  ('7', '2020-05-30'),
  ('1', '2020-05-30'),
  ('7', '2020-05-31'),
  ('7', '2020-06-01'),
  ('7', '2020-06-02'),
  ('7', '2020-06-02'),
  ('7', '2020-06-03'),
  ('1', '2020-06-07'),
  ('7', '2020-06-10'); */

-- Solution:
with cte as(
  select Logins.id as 'id', name, login_date,
  lead(login_date,4) over(partition by Logins.id order by login_date) as 'fifth'
  from Logins join Accounts
  on Logins.id = Accounts.id
)

select distinct id, name
from cte
where datediff(fifth,login_date)>4
order by 1;