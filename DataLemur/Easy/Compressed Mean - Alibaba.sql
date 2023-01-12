/* Compressed Mean [Alibaba SQL Interview Question]
You are trying to find the mean number of items bought per order on Alibaba, rounded to 1 decimal place.
However, instead of doing analytics on all Alibaba orders, you have access to a summary table, which describes how many items were in
an order (item_count), and the number of orders that had that many items (order_occurrences).

Schema:
CREATE TABLE items_per_order (
  `item_count` INTEGER,
  `order_occurrences` INTEGER
);
INSERT INTO items_per_order
  (`item_count`, `order_occurrences`)
VALUES
  ('1', '500'),
  ('2', '1000'),
  ('3', '800'),
  ('4', '1000');

Output:
mean
2.7

Explanation:
Total items = (1*500) + (2*1000) + (3*800) + (4*1000) = 8900
Total orders = 500 + 1000 + 800 + 1000 = 3300
Mean = 8900 / 3300 = 2.7 */

-- Solution:
SELECT ROUND( SUM(item_count * order_occurrences)*1.0 / SUM(order_occurrences)*1.0 ,1) AS mean
FROM items_per_order;