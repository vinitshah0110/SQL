-- Question 620

-- X city opened a new cinema, many people would like to go to this cinema.
-- The cinema also gives out a poster indicating the movies’ ratings and descriptions.
-- Please write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'.
-- Order the result by rating.

-- Cinema table:
-- +---------+-----------+--------------+-----------+
-- |   id    | movie     |  description |  rating   |
-- +---------+-----------+--------------+-----------+
-- |   1     | War       |   great 3D   |   8.9     |
-- |   2     | Science   |   fiction    |   8.5     |
-- |   3     | irish     |   boring     |   6.2     |
-- |   4     | Ice song  |   Fantacy    |   8.6     |
-- |   5     | House card|   Interesting|   9.1     |
-- +---------+-----------+--------------+-----------+

-- Output table:
-- +---------+-----------+--------------+-----------+
-- |   id    | movie     |  description |  rating   |
-- +---------+-----------+--------------+-----------+
-- |   5     | House card|   Interesting|   9.1     |
-- |   1     | War       |   great 3D   |   8.9     |
-- +---------+-----------+--------------+-----------+

-- Schema:
/* CREATE TABLE cinema (
  `id` INTEGER,
  `movie` VARCHAR(10),
  `description` VARCHAR(11),
  `rating` FLOAT
);

INSERT INTO cinema
  (`id`, `movie`, `description`, `rating`)
VALUES
  ('1', 'War', 'great 3D', '8.9'),
  ('2', 'Science', 'fiction', '8.5'),
  ('3', 'irish', 'boring', '6.2'),
  ('4', 'Ice song', 'Fantacy', '8.6'),
  ('5', 'House card', 'Interesting', '9.1'); */

-- Solution:
select * 
from cinema
where id % 2 = 1 and description != 'boring'
order by 4 desc;