/* Supercloud Customer [Microsoft SQL Interview Question]
A Microsoft Azure Supercloud customer is a company which buys at least 1 product from each product category.
Write a query to report the company ID which is a Supercloud customer.

Schema:
CREATE TABLE customer_contracts (
  `customer_id` INTEGER,
  `product_id` INTEGER,
  `amount` INTEGER
);

INSERT INTO customer_contracts
  (`customer_id`, `product_id`, `amount`)
VALUES
  ('1', '1', '1000'),
  ('1', '3', '2000'),
  ('1', '5', '1500'),
  ('2', '2', '3000'),
  ('2', '6', '2000');

CREATE TABLE products (
  `product_id` INTEGER,
  `product_category` VARCHAR(10),
  `product_name` VARCHAR(24)
);

INSERT INTO products
  (`product_id`, `product_category`, `product_name`)
VALUES
  ('1', 'Analytics', 'Azure Databricks'),
  ('2', 'Analytics', 'Azure Stream Analytics'),
  ('3', 'Containers', 'Azure Kubernetes Service'),
  ('4', 'Containers', 'Azure Service Fabric'),
  ('5', 'Compute', 'Virtual Machines'),
  ('6', 'Compute', 'Azure Functions'); 

Output:
customer_id
1 */

-- Solution:
SELECT customer_id 
FROM customer_contracts JOIN products
ON customer_contracts.product_id = products.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);