/* Laptop vs. Mobile Viewership [New York Times SQL Interview Question] 
Assume that you are given the table below containing information on viewership by device type (where the three types are laptop,
tablet, and phone). Define “mobile” as the sum of tablet and phone viewership numbers. 
Write a query to compare the viewership on laptops versus mobile devices.
Output the total viewership for laptop and mobile devices in the format of "laptop_views" and "mobile_views".

Schema:
CREATE TABLE viewership (
  `user_id` INTEGER,
  `device_type` VARCHAR(6)
);
INSERT INTO viewership
  (`user_id`, `device_type`)
VALUES
  ('123', 'tablet'),
  ('125', 'laptop'),
  ('128', 'laptop'),
  ('129', 'phone'),
  ('145', 'tablet'); 
  
Output:
laptop_views	mobile_views
2	3 */

-- Solution:
SELECT 
COUNT(CASE WHEN device_type IN('laptop') THEN user_id END) AS laptop_views,
COUNT(CASE WHEN device_type IN('tablet','phone') THEN user_id END) AS mobile_views
FROM viewership;