/* Cards Issued Difference [JPMorgan Chase SQL Interview Question]
Your team at JPMorgan Chase is soon launching a new credit card, and to gain some context, you are analyzing how many credit cards
were issued each month.
Write a query that outputs the name of each credit card & the difference in issued amount between the month with the most cards issued,
and the least cards issued. Order the results according to the biggest difference.

Schema:
CREATE TABLE monthly_cards_issued (
  `card_name` VARCHAR(22),
  `issued_amount` INTEGER,
  `issue_month` INTEGER,
  `issue_year` INTEGER
);

INSERT INTO monthly_cards_issued
  (`card_name`, `issued_amount`, `issue_month`, `issue_year`)
VALUES
  ('Chase Freedom Flex', '55000', '1', '2021'),
  ('Chase Freedom Flex', '60000', '2', '2021'),
  ('Chase Freedom Flex', '65000', '3', '2021'),
  ('Chase Freedom Flex', '70000', '4', '2021'),
  ('Chase Sapphire Reserve', '170000', '1', '2021'),
  ('Chase Sapphire Reserve', '175000', '2', '2021'),
  ('Chase Sapphire Reserve', '180000', '3', '2021');
  
Output:
card_name	difference
Chase Freedom Flex	15000
Chase Sapphire Reserve	10000 */

-- Solution:
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;