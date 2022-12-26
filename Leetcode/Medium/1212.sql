-- Question 1212

-- Table: Teams
-- +---------------+----------+
-- | Column Name   | Type     |
-- +---------------+----------+
-- | team_id       | int      |
-- | team_name     | varchar  |
-- +---------------+----------+
-- team_id is the primary key of this table.
-- Each row of this table represents a single football team.

-- Table: Matches
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | host_team     | int     |
-- | guest_team    | int     | 
-- | host_goals    | int     |
-- | guest_goals   | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a finished match between two different teams. 
-- host_team and guest_team are represented by their IDs in the teams table & they scored host_goals and guest_goals goals respectively.
 
-- You would like to compute the scores of all teams after all matches. Points are awarded as follows:
-- A team receives three points if they win a match (Score strictly more goals than the opponent team).
-- A team receives one point if they draw a match (Same number of goals as the opponent team).
-- A team receives no points if they lose a match (Score less goals than the opponent team).
-- Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches. 
-- Result table should be ordered by num_points (decreasing order). In case of a tie, order the records by team_id (increasing order).

-- Teams table:
-- +-----------+--------------+
-- | team_id   | team_name    |
-- +-----------+--------------+
-- | 10        | Leetcode FC  |
-- | 20        | NewYork FC   |
-- | 30        | Atlanta FC   |
-- | 40        | Chicago FC   |
-- | 50        | Toronto FC   |
-- +-----------+--------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 10           | 20            | 3           | 0            |
-- | 2          | 30           | 10            | 2           | 2            |
-- | 3          | 10           | 50            | 5           | 1            |
-- | 4          | 20           | 30            | 1           | 0            |
-- | 5          | 50           | 30            | 1           | 0            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +------------+--------------+---------------+
-- | team_id    | team_name    | num_points    |
-- +------------+--------------+---------------+
-- | 10         | Leetcode FC  | 7             |
-- | 20         | NewYork FC   | 3             |
-- | 50         | Toronto FC   | 3             |
-- | 30         | Atlanta FC   | 1             |
-- | 40         | Chicago FC   | 0             |
-- +------------+--------------+---------------+

-- Schema:
/* CREATE TABLE Teams (
  `team_id` INTEGER,
  `team_name` VARCHAR(11)
);

INSERT INTO Teams
  (`team_id`, `team_name`)
VALUES
  ('10', 'Leetcode FC'),
  ('20', 'NewYork FC'),
  ('30', 'Atlanta FC'),
  ('40', 'Chicago FC'),
  ('50', 'Toronto FC');

CREATE TABLE Matches (
  `match_id` INTEGER,
  `host_team` INTEGER,
  `guest_team` INTEGER,
  `host_goals` INTEGER,
  `guest_goals` INTEGER
);

INSERT INTO Matches
  (`match_id`, `host_team`, `guest_team`, `host_goals`, `guest_goals`)
VALUES
  ('1', '10', '20', '3', '0'),
  ('2', '30', '10', '2', '2'),
  ('3', '10', '50', '5', '1'),
  ('4', '20', '30', '1', '0'),
  ('5', '50', '30', '1', '0'); */

-- Solution
with tournament as(
  select * from Matches
    union all
  select match_id, guest_team, host_team, guest_goals, host_goals
  from Matches
)

select team_id, team_name,
sum(
  case
    when host_goals>guest_goals then 3
    when host_goals=guest_goals then 1
    else 0
  end
) as 'num_points'
from Teams left join tournament
on team_id = host_team
group by team_id, team_name
order by 3 desc, 1;