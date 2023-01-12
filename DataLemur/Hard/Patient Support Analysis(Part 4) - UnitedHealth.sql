/* Patient Support Analysis (Part 4) [UnitedHealth SQL Interview Question]
A long-call is categorised as any call that lasts more than 5 minutes (300 seconds). What's the month-over-month growth of long-calls?
Output the year, month (both in numerical and chronological order) and growth percentage rounded to 1 decimal place.

Schema:
CREATE TABLE callers (
  `policy_holder_id` INTEGER,
  `case_id` VARCHAR(19),
  `call_received` VARCHAR(19),
  `call_duration_secs` INTEGER,
  `original_order` INTEGER
);

INSERT INTO callers
  (`policy_holder_id`, `case_id`, `call_received`, `call_duration_secs`, `original_order`)
VALUES
  ('50986511', 'b274-c8f0-4d5c-8704', '2022-01-28T09:46:00', '252', '456'),
  ('54026568', '405a-b9be-45c2-b311', '2022-01-29T16:19:00', '397', '217'),
  ('54026568', 'c4cc-fd40-4780-8a53', '2022-01-30T08:18:00', '320', '134'),
  ('54026568', '81e8-6abf-425b-add2', '2022-02-20T17:26:00', '1324', '83'),
  ('54475101', '5919-b9c2-49a5-8091', '2022-02-24T18:07:00', '206', '498'),
  ('54624612', 'a17f-a415-4727-9a3f', '2022-02-27T10:56:00', '435', '19'),
  ('53777383', 'dfa9-e5a7-4a9b-a756', '2022-03-19T00:10:00', '318', '69'),
  ('52880317', 'cf00-56c4-4e76-963a', '2022-03-21T01:12:00', '340', '254'),
  ('52680969', '0c3c-7b87-489a-9857', '2022-03-21T14:00:00', '310', '213'),
  ('54574775', 'ca73-bf99-46b2-a79b', '2022-04-18T14:09:00', '181', '312'),
  ('51435044', '6546-61b4-4a05-9a5e', '2022-04-18T21:58:00', '354', '439'),
  ('52780643', 'e35a-a7c2-4718-a65d', '2022-05-06T14:31:00', '318', '186'),
  ('54026568', '61ac-eee7-42fa-a674', '2022-05-07T01:27:00', '404', '341'),
  ('54674449', '3d9d-e6e2-49d5-a1a0', '2022-05-09T11:00:00', '107', '450'),
  ('54026568', 'c516-0063-4b8f-aa74', '2022-05-13T01:06:00', '404', '270');

Output:
yr	mth	growth_pct
2022	1	null
2022	2	0.0
2022	3	50.0
2022	4	-66.7
2022	5	200.0 */

-- Solution:
WITH cte AS(
SELECT YEAR(call_received) AS yr, MONTH(call_received) AS mth,
COUNT(case_id) AS cnt
FROM callers
WHERE call_duration_secs>300
GROUP BY YEAR(call_received), MONTH(call_received)
)

SELECT yr, mth,
ROUND(((cnt - LAG(cnt,1) OVER(ORDER BY yr, mth))/LAG(cnt,1) OVER(ORDER BY yr, mth))*100.0,1) AS growth_pct
FROM cte;