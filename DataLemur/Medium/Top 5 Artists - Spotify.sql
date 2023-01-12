/* Top 5 Artists [Spotify SQL Interview Question] 
Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times.
Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, 
but the rank of who has the most appearances). The order of the rank should take precedence.

Schema:
CREATE TABLE artists (
  `artist_id` INTEGER,
  `artist_name` VARCHAR(10)
);

INSERT INTO artists
  (`artist_id`, `artist_name`)
VALUESTop 5 Artists [Spotify
  ('101', 'Ed Sheeran'),
  ('120', 'Drake');

CREATE TABLE songs (
  `song_id` INTEGER,
  `artist_id` INTEGER
);

INSERT INTO songs
  (`song_id`, `artist_id`)
VALUES
  ('45202', '101'),
  ('19960', '120');

CREATE TABLE global_song_rank (
  `day` INTEGER,
  `song_id` INTEGER,
  `rank` INTEGER
);

INSERT INTO global_song_rank
  (`day`, `song_id`, `rank`)
VALUES
  ('1', '45202', '5'),
  ('3', '45202', '2'),
  ('1', '19960', '3'),
  ('9', '19960', '15'); 

Output:
artist_name	artist_rank
Ed Sheeran	1
Drake	2 */

-- Solution:
WITH cte AS(
 SELECT artists.artist_name,
 DENSE_RANK() OVER(ORDER BY COUNT(global_song_rank.song_id) DESC) AS artist_rank
 FROM songs JOIN artists
 ON songs.artist_id = artists.artist_id
 JOIN global_song_rank
 ON songs.song_id = global_song_rank.song_id AND global_song_rank.rank<11
 GROUP BY artists.artist_name
)

SELECT artist_name, artist_rank
FROM cte 
WHERE artist_rank<6;