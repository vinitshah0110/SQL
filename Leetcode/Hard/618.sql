-- Question 618

-- A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
-- | name   | continent |
-- |--------|-----------|
-- | Jack   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jane   | America   |
 
-- Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.

-- Output table:
-- | America | Asia | Europe |
-- |---------|------|--------|
-- | Jack    | Xi   | Pascal |
-- | Jane    |      |        |

-- Schema:
/* CREATE TABLE student (
  `name` VARCHAR(6),
  `continent` VARCHAR(7)
);

INSERT INTO student
  (`name`, `continent`)
VALUES
  ('Jack', 'America'),
  ('Pascal', 'Europe'),
  ('Xi', 'Asia'),
  ('Jane', 'America'); */

-- Solution
with cte as(
  select *,
  row_number() over(partition by continent) as 'rn'
  from student
)

select
max(case when continent='America' then name end) as 'America',
max(case when continent='Asia' then name end) as 'Asia',
max(case when continent='Europe' then name end) as 'Europe'
from cte
group by rn;