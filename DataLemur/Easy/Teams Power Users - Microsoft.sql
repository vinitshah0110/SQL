/* Teams Power Users [Microsoft SQL Interview Question]
Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. 
Output the results in descending count of the messages.

Schema:
CREATE TABLE messages (
  `message_id` INTEGER,
  `sender_id` INTEGER,
  `receiver_id` INTEGER,
  `content` VARCHAR(23),
  `sent_date` DATETIME
);

INSERT INTO messages
  (`message_id`, `sender_id`, `receiver_id`, `content`, `sent_date`)
VALUES
  ('901', '3601', '4500', 'You up?', '2022/08/03 00:00:00'),
  ('902', '4500', '3601', 'Only if youre buying', '2022/08/03 00:00:00'),
  ('743', '3601', '8752', 'Lets take this offline', '2022/06/14 00:00:00'),
  ('922', '3601', '4500', 'Get on the call', '2022/08/10 00:00:00'); 

Output:
sender_id	message_count
3601	2
4500	1 */

-- Solution 1:
SELECT sender_id, COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date)=08 AND EXTRACT(YEAR FROM sent_date)=2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

-- Solution 2:
WITH cte AS(
 SELECT sender_id, COUNT(message_id) AS message_count,
 DENSE_RANK() OVER(ORDER BY COUNT(message_id) DESC) AS rk
 FROM messages
 WHERE EXTRACT(MONTH FROM sent_date)=08 AND EXTRACT(YEAR FROM sent_date)=2022
 GROUP BY sender_id
)

SELECT sender_id, message_count
FROM cte
WHERE rk<3;