-- Question 614

-- In facebook, there is a follow table with two columns: followee, follower.
-- Write a sql query to get the amount of each follower’s follower if he/she has one.

-- +-------------+------------+
-- | followee    | follower   |
-- +-------------+------------+
-- |     A       |     B      |
-- |     B       |     C      |
-- |     B       |     D      |
-- |     D       |     E      |
-- +-------------+------------+

-- Output:
-- +-------------+------------+
-- | follower    | num        |
-- +-------------+------------+
-- |     B       |  2         |
-- |     D       |  1         |
-- +-------------+------------+
-- Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
-- Followee would not follow himself/herself in all cases.
-- Display the result in follower's alphabet order.

-- Schema:
/* CREATE TABLE follow (
  `followee` VARCHAR(1),
  `follower` VARCHAR(1)
);

INSERT INTO follow
  (`followee`, `follower`)
VALUES
  ('A', 'B'),
  ('B', 'C'),
  ('B', 'D'),
  ('D', 'E'); */

-- Solution
select followee as 'follower', count(follower) as 'num'
from follow
where followee in (select follower from follow)
group by followee
order by 1;