/* 571 Find Median Given Frequency of Numbers
Numbers table keeps the value of number and its frequency. Write a query to find median of all numbers and name the result as median
+----------+-------------+
|  Number  |  Frequency  |
+----------+-------------|
|  0       |  7          |
|  1       |  1          |
|  2       |  3          |
|  3       |  1          |
+----------+-------------+
In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

Schema:
CREATE TABLE Numbers (
  `Number` INTEGER,
  `Frequency` INTEGER
);

INSERT INTO Numbers
  (`Number`, `Frequency`)
VALUES
  ('0', '7'),
  ('1', '1'),
  ('2', '3'),
  ('3', '1');

Output:
+--------+
| median |
+--------|
| 0.0000 |
+--------+ */

-- Solution:
with cte as(
  select Number,
  sum(Frequency) over() as 'total_numbers',
  sum(Frequency) over(order by Number) - Frequency as 'start_flag',
  sum(Frequency) over(order by Number) as 'end_flag'
  from Numbers
)

select avg(Number) as median
from cte
where total_numbers/2.0 between start_flag and end_flag;