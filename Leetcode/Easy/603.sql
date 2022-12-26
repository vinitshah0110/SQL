-- Question 603

-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 
-- Your query should return the following result for the sample case above.
-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |

-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.

-- Schema
/* CREATE TABLE cinema (
  `seat_id` INTEGER,
  `free` INTEGER
);

INSERT INTO cinema
  (`seat_id`, `free`)
VALUES
  ('1', '1'),
  ('2', '0'),
  ('3', '1'),
  ('4', '1'),
  ('5', '1'); */

-- Solution
with cte as (
  select *,
  seat_id - row_number() over(order by seat_id) as 'gap'
  from cinema
  where free = 1
)

select seat_id from cte
where gap in ( select gap from cte group by gap having count(1)>1 )