/* Spotify Streaming History [Spotify SQL Interview Question]
Write a query to output the user id, song id, and cumulative count of song plays as of 4 August 2022 sorted in descending order.
song_weekly table currently holds data from 1 August 2022 to 7 August 2022.
songs_history table currently holds data up to to 31 July 2022. The output should include the historical data in this table.

Schema:
CREATE TABLE songs_history (
  `history_id` INTEGER,
  `user_id` INTEGER,
  `song_id` INTEGER,
  `song_plays` INTEGER
);

INSERT INTO songs_history
  (`history_id`, `user_id`, `song_id`, `song_plays`)
VALUES
  ('10011', '777', '1238', '11'),
  ('12452', '695', '4520', '1');

CREATE TABLE songs_weekly (
  `user_id` INTEGER,
  `song_id` INTEGER,
  `listen_time` DATETIME
);

INSERT INTO songs_weekly
  (`user_id`, `song_id`, `listen_time`)
VALUES
  ('777', '1238', '2022/08/01 12:00:00'),
  ('695', '4520', '2022/08/04 08:00:00'),
  ('125', '9630', '2022/08/04 16:00:00'),
  ('695', '9852', '2022/08/07 12:00:00');

Output:
user_id	song_id	song_plays
777	1238	12
695	4520	2
125	9630	1 */

-- Solution:
WITH cte AS(
 SELECT user_id, song_id, COUNT(listen_time) AS song_plays
 FROM songs_weekly
 WHERE listen_time < '2022/08/05'
 GROUP BY user_id, song_id
 
 UNION ALL
 SELECT user_id, song_id, song_plays
 FROM songs_history
)

SELECT user_id, song_id, SUM(song_plays) AS song_plays
FROM cte
GROUP BY user_id, song_id
ORDER BY 3 DESC;