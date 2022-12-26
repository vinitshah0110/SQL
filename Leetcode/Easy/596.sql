-- Question 596

-- Write an SQL query to report all the classes that have at least five students.
-- Return the result table in any order.

-- For example, the table:
-- +---------+------------+
-- | student | class      |
-- +---------+------------+
-- | A       | Math       |
-- | B       | English    |
-- | C       | Math       |
-- | D       | Biology    |
-- | E       | Math       |
-- | F       | Computer   |
-- | G       | Math       |
-- | H       | Math       |
-- | I       | Math       |
-- +---------+------------+

-- Output: 
-- +---------+
-- | class   |
-- +---------+
-- | Math    |
-- +---------+

-- Schema
/*
CREATE TABLE courses (
  `student` VARCHAR(1),
  `class` VARCHAR(8)
);

INSERT INTO courses
  (`student`, `class`)
VALUES
  ('A', 'Math'),
  ('B', 'English'),
  ('C', 'Math'),
  ('D', 'Biology'),
  ('E', 'Math'),
  ('F', 'Computer'),
  ('G', 'Math'),
  ('H', 'Math'),
  ('I', 'Math');
*/

-- Solution
select class 
from courses
group by class having count(distinct student)>4