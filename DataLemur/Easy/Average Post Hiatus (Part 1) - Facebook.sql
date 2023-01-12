/* Average Post Hiatus (Part 1) [Facebook SQL Interview Question]
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between
each user’s first post of the year and last post of the year in the year 2021. 
Output the user and number of the days between each user's first and last post.

Schema:
CREATE TABLE posts (
  `user_id` INTEGER,
  `post_id` INTEGER,
  `post_date` DATETIME,
  `post_content` VARCHAR(112)
);

INSERT INTO posts
  (`user_id`, `post_id`, `post_date`, `post_content`)
VALUES
  ('151652', '599415', '2021/07/10 12:00:00', 'Need a hug'),
  ('661093', '624356', '2021/07/29 13:00:00', 'Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10.'),
  ('004239', '784254', '2021/07/04 11:00:00', 'Happy 4th of July!'),
  ('661093', '442560', '2021/07/08 14:00:00', 'Just going to cry myself to sleep after watching Marley and Me.'),
  ('151652', '111766', '2021/07/12 19:00:00', 'Im so done with covid - need travelling ASAP!');

Output:
user_id	days_between
151652	2
661093	21 */

-- Solution:
SELECT user_id, DATEDIFF( MAX(post_date),MIN(post_date) ) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date)=2021
GROUP BY user_id HAVING COUNT(DISTINCT post_date)>1;