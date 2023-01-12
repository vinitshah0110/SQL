/* Patient Support Analysis (Part 2) [UnitedHealth SQL Interview Question]
UnitedHealth Group has a program called Advocate4Me, which allows members to call an advocate and receive support for their health
care needs – whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.
Calls to the Advocate4Me call centre are categorised, but sometimes they can't fit neatly into a category. 
These uncategorised calls are labelled “n/a”, or are just empty (when a support agent enters nothing into the category field).
Write a query to find the percentage of calls that cannot be categorised. Round your answer to 1 decimal place.

Schema:
CREATE TABLE callers (
  `policy_holder_id` INTEGER,
  `case_id` VARCHAR(19),
  `call_category` VARCHAR(10),
  `call_duration_secs` INTEGER,
  `original_order` INTEGER
);

INSERT INTO callers
  (`policy_holder_id`, `case_id`, `call_category`, `call_duration_secs`, `original_order`)
VALUES
  ('52481621', 'a94c-2213-4ba5-812d', NULL, '286', '161'),
  ('51435044', 'f0b5-0eb0-4c49-b21e', 'n/a', '208', '225'),
  ('52082925', '289b-d7e8-4527-bdf5', 'benefits', '291', '352'),
  ('54624612', '62c2-d9a3-44d2-9065', 'IT_support', '273', '358'),
  ('54624612', '9f57-164b-4a36-934e', 'claims', '157', '362');

Output:
call_percentage
40.0 */

-- Solution:
SELECT 
ROUND(( SUM(CASE WHEN call_category='n/a' OR call_category IS NULL THEN 1 ELSE 0 END) / COUNT(*) )*100.0,1) AS call_percentage
FROM callers;