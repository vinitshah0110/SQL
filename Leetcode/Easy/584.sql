-- Question 584

-- Given a table customer holding customers information and the referee.

-- +------+------+-----------+
-- | id   | name | referee_id|
-- +------+------+-----------+
-- |    1 | Will |      NULL |
-- |    2 | Jane |      NULL |
-- |    3 | Alex |         2 |
-- |    4 | Bill |      NULL |
-- |    5 | Zack |         1 |
-- |    6 | Mark |         2 |
-- +------+------+-----------+

-- Write a query to return the list of customers NOT referred by the person with id '2'.

-- For the sample data above, the result is:
-- +------+
-- | name |
-- +------+
-- | Will |
-- | Jane |
-- | Bill |
-- | Zack |
-- +------+

-- Schema:
/* CREATE TABLE  referee (
  `id` INTEGER,
  `name` VARCHAR(4),
  `referee_id` VARCHAR(4)
);

INSERT INTO  referee
  (`id`, `name`, `referee_id`)
VALUES
  ('1', 'Will', null),
  ('2', 'Jane', null),
  ('3', 'Alex', 2),
  ('4', 'Bill', null),
  ('5', 'Zack', 1),
  ('6', 'Mark', 2); */

-- Solution:
select name from referee
where ifnull(referee_id,0) != 2