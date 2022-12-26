-- Question 585

-- Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders who meet the following criteria:
-- Have the same TIV_2015 value as one or more other policyholders.
-- Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).

-- Input Format:
-- | Column Name | Type          |
-- |-------------|---------------|
-- | PID         | INTEGER(11)   |
-- | TIV_2015    | NUMERIC(15,2) |
-- | TIV_2016    | NUMERIC(15,2) |
-- | LAT         | NUMERIC(5,2)  |
-- | LON         | NUMERIC(5,2)  |
-- where PID is the policyholder's policy ID, TIV_2015 is the total investment value in 2015, TIV_2016 is the total investment value in 2016, LAT is the latitude of the policy holder's city, and LON is the longitude of the policy holder's city.

-- Sample Input
-- | PID | TIV_2015 | TIV_2016 | LAT | LON |
-- |-----|----------|----------|-----|-----|
-- | 1   | 10       | 5        | 10  | 10  |
-- | 2   | 20       | 20       | 20  | 20  |
-- | 3   | 10       | 30       | 20  | 20  |
-- | 4   | 10       | 40       | 40  | 40  |

-- Sample Output
-- | TIV_2016 |
-- |----------|
-- | 45.00    |
-- The first record in the table, like the last record, meets both of the two criteria.
-- The TIV_2015 value '10' is as the same as the third and forth record, and its location unique.
-- The second record does not meet any of the two criteria. Its TIV_2015 is not like any other policyholders.
-- And its location is the same with the third record, which makes the third record fail, too.
-- So, the result is the sum of TIV_2016 of the first and last record, which is 45.

-- Schema:
/* CREATE TABLE insurance (
  `PID` INTEGER,
  `TIV_2015` INTEGER,
  `TIV_2016` INTEGER,
  `LAT` INTEGER,
  `LON` INTEGER
);

INSERT INTO insurance
  (`PID`, `TIV_2015`, `TIV_2016`, `LAT`, `LON`)
VALUES
  ('1', '10', '5', '10', '10'),
  ('2', '20', '20', '20', '20'),
  ('3', '10', '30', '20', '20'),
  ('4', '10', '40', '40', '40'); */

-- Solution:
with cte as(
  select *,
  count(PID) over(partition by LAT, LON) as 'city_cnt'
  from insurance
)

, b as(
  select *,
  count(TIV_2015) over(partition by TIV_2015) as 'tiv_cnt'
  from cte
  where city_cnt=1
)

select sum(TIV_2016)*1.00 as 'TIV_2016' from b
where tiv_cnt>1;