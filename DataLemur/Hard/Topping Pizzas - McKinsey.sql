/* 3-Topping Pizzas [McKinsey SQL Interview Question]
You’re a consultant for a major pizza chain that will be running a promotion where all 3-topping pizzas will be sold for a fixed price,
and are trying to understand the costs involved.
Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. 
Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

Schema:
CREATE TABLE pizza_toppings (
  `topping_name` VARCHAR(12),
  `ingredient_cost` FLOAT
);

INSERT INTO pizza_toppings
  (`topping_name`, `ingredient_cost`)
VALUES
  ('Pepperoni', '0.50'),
  ('Sausage', '0.70'),
  ('Chicken', '0.55'),
  ('Extra Cheese', '0.40');

Output:
pizza	total_cost
Chicken,Pepperoni,Sausage	1.75
Chicken,Extra Cheese,Sausage	1.65
Extra Cheese,Pepperoni,Sausage	1.60
Chicken,Extra Cheese,Pepperoni	1.45 */

-- Solution
SELECT CONCAT_WS(',',topping1.topping_name, topping2.topping_name, topping3.topping_name) AS pizza,
FORMAT((topping1.ingredient_cost + topping2.ingredient_cost + topping3.ingredient_cost),2) AS total_cost
FROM pizza_toppings topping1 JOIN pizza_toppings topping2
ON topping1.topping_name < topping2.topping_name
JOIN pizza_toppings topping3
ON topping2.topping_name < topping3.topping_name
ORDER BY 2 DESC, 1;