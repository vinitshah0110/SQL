/* 2173. Longest Winning Streak

The winning streak of a player is the number of consecutive wins uninterrupted by draws or losses.
Write an SQL query to count the longest winning streak for each player.
Return the result table in any order.

Matches table:
+-----------+------------+--------+
| player_id | match_day  | result |
+-----------+------------+--------+
| 1         | 2022-01-17 | Win    |
| 1         | 2022-01-18 | Win    |
| 1         | 2022-01-25 | Win    |
| 1         | 2022-01-31 | Draw   |
| 1         | 2022-02-08 | Win    |
| 2         | 2022-02-06 | Lose   |
| 2         | 2022-02-08 | Lose   |
| 3         | 2022-03-30 | Win    |
+-----------+------------+--------+

Output table: 
+-----------+----------------+
| player_id | longest_streak |
+-----------+----------------+
| 1         | 3              |
| 2         | 0              |
| 3         | 1              |
+-----------+----------------+ 
Player 1:
From 2022-01-17 to 2022-01-25, player 1 won 3 consecutive matches.
On 2022-01-31, player 1 had a draw.
On 2022-02-08, player 1 won a match.
The longest winning streak was 3 matches.

Player 2:
From 2022-02-06 to 2022-02-08, player 2 lost 2 consecutive matches.
The longest winning streak was 0 matches.

Player 3:
On 2022-03-30, player 3 won a match.
The longest winning streak was 1 match.

Schema:
CREATE TABLE Matches (
  `player_id` INTEGER,
  `match_day` DATETIME,
  `result` VARCHAR(4)
);

INSERT INTO Matches
  (`player_id`, `match_day`, `result`)
VALUES
  ('1', '2022-01-17', 'Win'),
  ('1', '2022-01-18', 'Win'),
  ('1', '2022-01-25', 'Win'),
  ('1', '2022-01-31', 'Draw'),
  ('1', '2022-02-08', 'Win'),
  ('2', '2022-02-06', 'Lose'),
  ('2', '2022-02-08', 'Lose'),
  ('3', '2022-03-30', 'Win'); */

-- Solution:
with cte as(
  select player_id, result,
  row_number() over(partition by player_id order by match_day) as 'match_no'
  from Matches
)

, win as(
  select player_id,
  match_no - row_number() over(partition by player_id order by match_no) as 'gap'
  from cte
  where result='Win'
)

, streak as(
  select player_id, gap, count(gap) as 'streak'
  from win
  group by player_id, gap
)

select distinct Matches.player_id, ifnull(max(streak) over(partition by Matches.player_id),0) as 'longest_streak'
from Matches left join streak
on Matches.player_id = streak.player_id;