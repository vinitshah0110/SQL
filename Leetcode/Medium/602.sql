-- Question 602

-- Table request_accepted
-- +--------------+-------------+------------+
-- | requester_id | accepter_id | accept_date|
-- |--------------|-------------|------------|
-- | 1            | 2           | 2016_06-03 |
-- | 1            | 3           | 2016-06-08 |
-- | 2            | 3           | 2016-06-08 |
-- | 3            | 4           | 2016-06-09 |
-- +--------------+-------------+------------+
-- This table holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
 
-- Write a query to find the the people who has most friends and the most friends number under the following rules:
-- It is guaranteed there is only 1 people having the most friends.
-- The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
-- For the sample data above, the result is:

-- Result table:
-- +------+------+
-- | id   | num  |
-- |------|------|
-- | 3    | 3    |
-- +------+------+
-- The person with id '3' is a friend of people '1', '2' and '4', so he has 3 friends in total, which is the most number than any others.

-- Schema:
/* CREATE TABLE request_accepted (
  `requester_id` INTEGER,
  `accepter_id` INTEGER,
  `accept_date` VARCHAR(10)
);

INSERT INTO request_accepted
  (`requester_id`, `accepter_id`, `accept_date`)
VALUES
  ('1', '2', '2016_06-03'),
  ('1', '3', '2016-06-08'),
  ('2', '3', '2016-06-08'),
  ('3', '4', '2016-06-09'); */

-- Solution:
with cte as(
  select requester_id, accepter_id
  from request_accepted
  union all
  select accepter_id, requester_id
  from request_accepted
)

, b as(
  select requester_id, count(accepter_id) as 'num',
  dense_rank() over(order by count(accepter_id) desc) as 'rk'
  from cte
  group by requester_id
)

select requester_id, num
from b
where rk=1;