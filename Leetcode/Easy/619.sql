-- Question 619

-- Table my_numbers contains many numbers in column num including duplicated ones.
-- Can you write a SQL query to find the biggest number, which only appears once.

-- +---+
-- |num|
-- +---+
-- | 8 |
-- | 8 |
-- | 3 |
-- | 3 |
-- | 1 |
-- | 4 |
-- | 5 |
-- | 6 | 

-- For the sample data above, your query should return the following result:
-- +---+
-- |num|
-- +---+
-- | 6 |

-- Note:
-- If there is no such number, just output null.

--Schema
/*
CREATE TABLE my_numbers (
  `num` INTEGER
);

INSERT INTO my_numbers
  (`num`)
VALUES
  ('8'),
  ('8'),
  ('3'),
  ('3'),
  ('1'),
  ('4'),
  ('4'),
  ('1');
*/

-- Solution
select ifnull(max(num), null) as 'num'
from 
(
  select num
  from my_numbers
  group by num
  having count(1) = 1
) temp