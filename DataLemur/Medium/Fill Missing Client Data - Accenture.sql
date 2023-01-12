/* Fill Missing Client Data [Accenture SQL Interview Question]
When you log in to your retailer client's database, you notice that their product catalog data is full of gaps in the category column. 
Can you write a SQL query that returns the product catalog with the missing data filled in?

Schema:
CREATE TABLE products (
  `product_id` INTEGER,
  `category` VARCHAR(31),
  `name` VARCHAR(30)
);

INSERT INTO products
  (`product_id`, `category`, `name`)
VALUES
  ('1', 'Shoes', 'Sperry Boat Shoe'),
  ('2', null, 'Adidas Stan Smith'),
  ('3', null, 'Vans Authentic'),
  ('4', 'Jeans', 'Levi 511'),
  ('5', null, 'Wrangler Straight Fit'),
  ('6', 'Shirts', 'Lacoste Classic Polo'),
  ('7', null, 'Nautica Linen Shirt');

Output:
product_id	category	name
1	Shoes	Sperry Boat Shoe
2	Shoes	Adidas Stan Smith
3	Shoes	Vans Authentic
4	Jeans	Levi 511
5	Jeans	Wrangler Straight Fit
6	Shirts	Lacoste Classic Polo
7	Shirts	Nautica Linen Shirt */

-- Solution:
WITH cte AS(
 SELECT product_id, category,
 LEAD(product_id,1,999) OVER(ORDER BY product_id)-1 AS end_id
 FROM products
 WHERE category IS NOT NULL
)

SELECT products.product_id, cte.category, products.name
FROM products JOIN cte
ON products.product_id BETWEEN cte.product_id AND cte.end_id;