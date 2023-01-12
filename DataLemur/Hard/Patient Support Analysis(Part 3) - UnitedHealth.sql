/* Patient Support Analysis (Part 3) [UnitedHealth SQL Interview Question]
Write a query to get the patients who made a call within 7 days of their previous call. 
If a patient called more than twice in a span of 7 days, count them as once.

Schema:
CREATE TABLE callers (
  `policy_holder_id` INTEGER,
  `case_id` VARCHAR(19),
  `call_category` VARCHAR(15),
  `call_received` DATETIME,
  `call_duration_secs` INTEGER,
  `original_order` INTEGER
);

INSERT INTO callers
  (`policy_holder_id`, `case_id`, `call_category`, `call_received`, `call_duration_secs`, `original_order`)
VALUES
  ('50837000', 'dc63-acae-4f39-bb04', 'claims', '2022/3/9 2:51', '205', '130'),
  ('50837000', '41be-bebe-4bd0-a1ba', 'IT_support', '2022/3/12 5:37', '254', '129'),
  ('50837000', 'bab1-3ec5-4867-90ae', 'benefits', '2022/5/13 18:19', '228', '339'),
  ('50936674', '12c8-b35c-48a3-b38d', 'claims', '2022/5/31 7:27', '240', '31'),
  ('50886837', 'd0b4-8ea7-4b8c-aa8b', 'IT_support', '2022/3/11 3:38', '276', '16'),
  ('50886837', 'a741-c279-41c0-90ba', null, '2022/3/19 10:52', '131', '325');

Output:
patient_count
1 */

-- Solution:
SELECT COUNT(DISTINCT c1.policy_holder_id) AS patient_count
FROM callers c1 JOIN callers c2
ON c1.policy_holder_id = c2.policy_holder_id AND c1.call_received > c2.call_received AND 
DATEDIFF(c1.call_received,c2.call_received)<7;