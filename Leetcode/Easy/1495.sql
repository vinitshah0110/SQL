-- Question 1495

-- Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
-- Return the result table in any order.

-- TVProgram table:
-- +--------------------+--------------+-------------+
-- | program_date       | content_id   | channel     |
-- +--------------------+--------------+-------------+
-- | 2020-06-10 08:00   | 1            | LC-Channel  |
-- | 2020-05-11 12:00   | 2            | LC-Channel  |
-- | 2020-05-12 12:00   | 3            | LC-Channel  |
-- | 2020-05-13 14:00   | 4            | Disney Ch   |
-- | 2020-06-18 14:00   | 4            | Disney Ch   |
-- | 2020-07-15 16:00   | 5            | Disney Ch   |
-- +--------------------+--------------+-------------+

-- Content table:
-- +------------+----------------+---------------+---------------+
-- | content_id | title          | Kids_content  | content_type  |
-- +------------+----------------+---------------+---------------+
-- | 1          | Leetcode Movie | N             | Movies        |
-- | 2          | Alg. for Kids  | Y             | Series        |
-- | 3          | Database Sols  | N             | Series        |
-- | 4          | Aladdin        | Y             | Movies        |
-- | 5          | Cinderella     | Y             | Movies        |
-- +------------+----------------+---------------+---------------+

-- Result table:
-- +--------------+
-- | title        |
-- +--------------+
-- | Aladdin      |
-- +--------------+
-- "Leetcode Movie" is not a content for kids.
-- "Alg. for Kids" is not a movie.
-- "Database Sols" is not a movie
-- "Alladin" is a movie, content for kids and was streamed in June 2020.
-- "Cinderella" was not streamed in June 2020.

-- Schema:
/* CREATE TABLE TVProgram (
  `program_date` DATETIME,
  `content_id` INTEGER,
  `channel` VARCHAR(10)
);

INSERT INTO TVProgram
  (`program_date`, `content_id`, `channel`)
VALUES
  ('2020-06-10 08:00', '1', 'LC-Channel'),
  ('2020-05-11 12:00', '2', 'LC-Channel'),
  ('2020-05-12 12:00', '3', 'LC-Channel'),
  ('2020-05-13 14:00', '4', 'Disney Ch'),
  ('2020-06-18 14:00', '4', 'Disney Ch'),
  ('2020-07-15 16:00', '5', 'Disney Ch');

CREATE TABLE Content (
  `content_id` INTEGER,
  `title` VARCHAR(14),
  `Kids_content` VARCHAR(1),
  `content_type` VARCHAR(6)
);

INSERT INTO Content
  (`content_id`, `title`, `Kids_content`, `content_type`)
VALUES
  ('1', 'Leetcode Movie', 'N', 'Movies'),
  ('2', 'Alg. for Kids', 'Y', 'Series'),
  ('3', 'Database Sols', 'N', 'Series'),
  ('4', 'Aladdin', 'Y', 'Movies'),
  ('5', 'Cinderella', 'Y', 'Movies'); */

-- Solution:
select distinct title 
from Content join TVProgram
on Content.content_id = TVProgram.content_id and content_type = 'Movies'
where Kids_content = 'Y' and month(program_date) = 06 and year(program_date) = 2020