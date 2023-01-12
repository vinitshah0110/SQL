/* Signup Activation Rate [TikTok SQL Interview Question]
New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts.
Users may receive multiple text messages for account confirmation until they have confirmed their new account.
Write a query to find the activation rate of the users. Round the percentage to 2 decimal places.

Schema:
CREATE TABLE emails (
  `email_id` INTEGER,
  `user_id` INTEGER,
  `signup_date` DATETIME
);

INSERT INTO emails
  (`email_id`, `user_id`, `signup_date`)
VALUES
  ('125', '7771', '2022/06/14 00:00:00'),
  ('236', '6950', '2022/07/01 00:00:00'),
  ('433', '1052', '2022/07/09 00:00:00');

CREATE TABLE texts (
  `text_id` INTEGER,
  `email_id` INTEGER,
  `signup_action` VARCHAR(13)
);

INSERT INTO texts
  (`text_id`, `email_id`, `signup_action`)
VALUES
  ('6878', '125', 'Confirmed'),
  ('6920', '236', 'Not Confirmed'),
  ('6994', '236', 'Confirmed');

Output:
confirm_rate
0.67 */

-- Solution:
SELECT ROUND(COUNT(emails.email_id)*1.0 / (SELECT COUNT(DISTINCT email_id) FROM emails)*1.0,2) AS confirm_rate
FROM emails JOIN texts
ON emails.email_id = texts.email_id AND signup_action='Confirmed';