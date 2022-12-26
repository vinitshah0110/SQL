/* Table column x has these values like 5, 4, 56, -1, -5, -4  write a query to get sum(x) and (sum -x) within one query

Schema:
CREATE TABLE num (
  `x` VARCHAR(10)
);

INSERT INTO num
  (`x`)
VALUES
  ('5'),
  ('4'),
  ('5'),
  ('-1'),
  ('-5'),
  ('-4'); */

-- Solution 1:
select
sum(case when x<0 then x else 0 end) as 'neg',
sum(case when x>0 then x else 0 end) as 'pos'
from num;

-- Solution 2:
select * from
(
(SELECT SUM(x) FROM num WHERE x<0) a
join
(SELECT SUM(x) FROM num WHERE x>0) b
)