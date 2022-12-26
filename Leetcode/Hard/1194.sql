-- Question 1194

-- Table: Players
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | player_id   | int   |
-- | group_id    | int   |
-- +-------------+-------+
-- player_id is the primary key of this table.
-- Each row of this table indicates the group of each player.

-- Table: Matches
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | first_player  | int     |
-- | second_player | int     | 
-- | first_score   | int     |
-- | second_score  | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a match, first_player and second_player contain the player_id of each match.
-- first_score and second_score contain the number of points of the first_player and second_player respectively.
-- You may assume that, in each match, players belongs to the same group.
 
-- The winner in each group is the player who scored the maximum total points. In the case of a tie, the lowest player_id wins.
-- Write an SQL query to find the winner in each group.

-- Players table:
-- +-----------+------------+
-- | player_id | group_id   |
-- +-----------+------------+
-- | 15        | 1          |
-- | 25        | 1          |
-- | 30        | 1          |
-- | 45        | 1          |
-- | 10        | 2          |
-- | 35        | 2          |
-- | 50        | 2          |
-- | 20        | 3          |
-- | 40        | 3          |
-- +-----------+------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | first_player | second_player | first_score | second_score |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 15           | 45            | 3           | 0            |
-- | 2          | 30           | 25            | 1           | 2            |
-- | 3          | 30           | 15            | 2           | 0            |
-- | 4          | 40           | 20            | 5           | 2            |
-- | 5          | 35           | 50            | 1           | 1            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +-----------+------------+
-- | group_id  | player_id  |
-- +-----------+------------+ 
-- | 1         | 15         |
-- | 2         | 35         |
-- | 3         | 40         |
-- +-----------+------------+

/* CREATE TABLE Players (
  `player_id` INTEGER,
  `group_id` INTEGER
);

INSERT INTO Players
  (`player_id`, `group_id`)
VALUES
  ('15', '1'),
  ('25', '1'),
  ('30', '1'),
  ('45', '1'),
  ('10', '2'),
  ('35', '2'),
  ('50', '2'),
  ('20', '3'),
  ('40', '3');

CREATE TABLE Matches (
  `match_id` INTEGER,
  `first_player` INTEGER,
  `second_player` INTEGER,
  `first_score` INTEGER,
  `second_score` INTEGER
);

INSERT INTO Matches
  (`match_id`, `first_player`, `second_player`, `first_score`, `second_score`)
VALUES
  ('1', '15', '45', '3', '0'),
  ('2', '30', '25', '1', '2'),
  ('3', '30', '15', '2', '0'),
  ('4', '40', '20', '5', '2'),
  ('5', '35', '50', '1', '1'); */

-- Solution:
with matches as(
  select first_player, sum(first_score) as 'score'
  from(
    select first_player, first_score from Matches
      union all
    select second_player, second_score from Matches
  ) temp
  group by first_player
)

, grp as(
  select group_id, player_id,
  dense_rank() over(partition by group_id order by score desc, player_id) as 'rk'
  from Players left join matches
  on player_id = first_player
)

select group_id, player_id
from grp where rk=1;