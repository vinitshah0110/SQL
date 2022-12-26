-- Question 601

-- X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people
-- Write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

-- Stadium table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+

-- Output table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- Each day only have one row record, and the dates are increasing with id increasing.

-- Schema:
/* CREATE TABLE stadium (
  `id` INTEGER,
  `visit_date` DATE,
  `people` INTEGER
);

INSERT INTO stadium
  (`id`, `visit_date`, `people`)
VALUES
  ('1', '2017-01-01', '10'),
  ('2', '2017-01-02', '109'),
  ('3', '2017-01-03', '150'),
  ('4', '2017-01-04', '99'),
  ('5', '2017-01-05', '145'),
  ('6', '2017-01-06', '1455'),
  ('7', '2017-01-07', '199'),
  ('8', '2017-01-08', '188'); */

-- Solution
with cte as(
  select *, id - row_number() over() as 'gap'
  from stadium
  where people>=100
)

, temp as(
  select gap
  from cte
  group by gap having count(gap)>2
)

select id, visit_date, people
from cte
where gap in (select gap from temp);