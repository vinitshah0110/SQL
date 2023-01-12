/* Card Launch Success [JPMorgan Chase SQL Interview Question]
You are asked to estimate how many cards you'll issue in the first month.
Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. 
The launch month is the earliest record in the monthly_cards_issued table for a given card. 
Order the results starting from the biggest issued amount.

Schema:
CREATE TABLE monthly_cards_issued (
  `issue_month` INTEGER,
  `issue_year` INTEGER,
  `card_name` VARCHAR(22),
  `issued_amount` INTEGER
);

INSERT INTO monthly_cards_issued
  (`issue_month`, `issue_year`, `card_name`, `issued_amount`)
VALUES
  ('1', '2021', 'Chase Sapphire Reserve', '170000'),
  ('2', '2021', 'Chase Sapphire Reserve', '175000'),
  ('3', '2021', 'Chase Sapphire Reserve', '180000'),
  ('3', '2021', 'Chase Freedom Flex', '65000'),
  ('4', '2021', 'Chase Freedom Flex', '70000');

Output:
card_name	issued_amount
Chase Sapphire Reserve	170000
Chase Freedom Flex	65000 */

-- Solution:
WITH cte AS(
 SELECT card_name,	issued_amount,
 DENSE_RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS rk
 FROM monthly_cards_issued
)

SELECT card_name,	issued_amount
FROM cte 
WHERE rk=1
ORDER BY 2 DESC;