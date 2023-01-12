/* Patient Support Analysis (Part 1) [UnitedHealth SQL Interview Question]
UnitedHealth has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs
– whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.
Write a query to find how many UHG members made 3 or more calls. case_id column uniquely identifies each call made.

Schema:
CREATE TABLE callers (
  `policy_holder_id` INTEGER,
  `case_id` VARCHAR(19),
  `call_category` VARCHAR(19),
  `call_duration_secs` INTEGER,
  `original_order` INTEGER
);

INSERT INTO callers()
VALUES
  ('50837000', 'dc63-acae-4f39-bb04', 'claims', '205', '130'),
  ('50837000', '41be-bebe-4bd0-a1ba', 'IT_support', '254', '129'),
  ('50936674', '12c8-b35c-48a3-b38d', 'claims', '240', '31'),
  ('50886837', 'd0b4-8ea7-4b8c-aa8b', 'IT_support', '276', '16'),
  ('50886837', 'a741-c279-41c0-90ba', null, '131', '325'),
  ('50837000', 'bab1-3ec5-4867-90ae', 'benefits', '228', '339');

Output:
member_count
1 */

-- Solution:
WITH cte AS(
 SELECT policy_holder_id
 FROM callers
 GROUP BY policy_holder_id
 HAVING COUNT(case_id)>2
)

SELECT COUNT(policy_holder_id) AS member_count
from cte;