/* International Call Percentage [Verizon SQL Interview Question]
A phone call is considered an international call when the person calling is in a different country than the person receiving the call.
What percentage of phone calls are international? Round the result to 1 decimal.

Schema:
CREATE TABLE phone_calls (
  `caller_id` INTEGER,
  `receiver_id` INTEGER
);

INSERT INTO phone_calls
  (`caller_id`, `receiver_id`)
VALUES
  ('1', '2'),
  ('1', '5'),
  ('5', '1'),
  ('5', '6');

CREATE TABLE phone_info (
  `caller_id` INTEGER,
  `country_id` VARCHAR(2),
  `network` VARCHAR(8),
  `phone_number` VARCHAR(15)
);

INSERT INTO phone_info
  (`caller_id`, `country_id`, `network`, `phone_number`)
VALUES
  ('1', 'US', 'Verizon', '+1-212-897-1964'),
  ('2', 'US', 'Verizon', '+1-703-346-9529'),
  ('3', 'US', 'Verizon', '+1-650-828-4774'),
  ('4', 'US', 'Verizon', '+1-415-224-6663'),
  ('5', 'IN', 'Vodafone', '+91 7503-907302'),
  ('6', 'IN', 'Vodafone', '+91 2287-664895');

Output:
international_calls_pct
50.0 */

-- Solution:
SELECT
ROUND((SUM(CASE WHEN phone1.country_id != phone2.country_id THEN 1 ELSE 0 END)*1.0 / COUNT(phone_calls.caller_id)*1.0)*100.0,1) AS international_calls_pct
FROM phone_calls JOIN phone_info phone1
ON phone_calls.caller_id = phone1.caller_id
JOIN phone_info phone2
ON phone_calls.receiver_id = phone2.caller_id;