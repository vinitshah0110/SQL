/* Compressed Mode [Alibaba SQL Interview Question]
You are trying to find the most common (aka the mode) number of items bought per order on Alibaba.
However, instead of doing analytics on all Alibaba orders, you have access to a summary table, which describes how many items were in
an order (item_count), and the number of orders that had that many items (order_occurrences).
In case of multiple item counts, display the item_counts in ascending order.

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

item_count
2
4 */

-- Solution:
WITH cte AS(
 SELECT order_occurrences, COUNT(order_occurrences)
 FROM items_per_order
 GROUP BY order_occurrences
 ORDER BY COUNT(order_occurrences) DESC, order_occurrences DESC
 LIMIT 1
)

SELECT item_count 
FROM items_per_order
WHERE order_occurrences = (SELECT order_occurrences FROM cte)
ORDER BY 1;