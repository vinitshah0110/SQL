/* Second Day Confirmation [TikTok SQL Interview Question]
Write a query to display the ids of the users who did not confirm on the first day of sign-up, but confirmed on the second day.

Schema:
CREATE TABLE emails (
  `email_id` INTEGER,
  `user_id` INTEGER,
  `signup_date` DATETIME
);

INSERT INTO emails
  (`email_id`, `user_id`, `signup_date`)
VALUES
  ('125', '7771', '2022/06/14/ 00:00:00'),
  ('433', '1052', '2022/07/09 00:00:00');

CREATE TABLE texts (
  `text_id` INTEGER,
  `email_id` INTEGER,
  `signup_action` VARCHAR(13),
  `action_date` DATETIME
);

INSERT INTO texts
  (`text_id`, `email_id`, `signup_action`, `action_date`)
VALUES
  ('6878', '125', 'Confirmed', '2022/06/14/ 00:00:00'),
  ('6997', '433', 'Not Confirmed', '2022/07/09 00:00:00'),
  ('7000', '433', 'Confirmed', '2022/07/10 00:00:00');

Output:
user_id
1052 */

-- Solution:
SELECT emails.user_id
FROM emails JOIN texts
ON emails.email_id = texts.email_id AND signup_action = 'Confirmed'
AND DATEDIFF(action_date,signup_date)=1;