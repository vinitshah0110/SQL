/* App Click-through Rate (CTR) [Facebook SQL Interview Question]
Write a query to get the app’s click-through rate (CTR %) in 2022. Output the results in percentages rounded to 2 decimal places.
Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions

Schema:
CREATE TABLE events (
  `app_id` INTEGER,
  `event_type` VARCHAR(10),
  `timestamp` DATETIME
);

INSERT INTO events
  (`app_id`, `event_type`, `timestamp`)
VALUES
  ('123', 'impression', '2022/07/18 11:36:12'),
  ('123', 'impression', '2022/07/18 11:37:12'),
  ('123', 'click', '2022/07/18 11:37:42'),
  ('234', 'impression', '2022/07/18 14:15:12'),
  ('234', 'click', '2022/07/18 14:16:12');

Output:
app_id	ctr
123	50.00
234	100.00 */

-- Solution:
SELECT app_id,
ROUND((SUM(CASE WHEN event_type='click' THEN 1 ELSE 0 END)*1.0 / SUM(CASE WHEN event_type='impression' THEN 1 ELSE 0 END)*1.0 )*100.0,2) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp)=2022
GROUP BY app_id;