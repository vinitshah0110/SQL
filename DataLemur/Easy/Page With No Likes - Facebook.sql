/* Page With No Likes [Facebook SQL Interview Question]
Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

Schema:
CREATE TABLE pages (
  `page_id` INTEGER,
  `page_name` VARCHAR(22)
);
INSERT INTO pages
  (`page_id`, `page_name`)
VALUES
  ('20001', 'SQL Solutions'),
  ('20045', 'Brain Exercises'),
  ('20701', 'Tips for Data Analysts');

CREATE TABLE page_likes (
  `user_id` INTEGER,
  `page_id` INTEGER
);
INSERT INTO page_likes
  (`user_id`, `page_id`)
VALUES
  ('111', '20001'),
  ('121', '20045'),
  ('156', '20001');

Output:
page_id
20701 */

-- Solution 1:
SELECT pages.page_id 
FROM pages LEFT JOIN page_likes
ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL
ORDER BY 1;

-- Solution 2:
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY 1;