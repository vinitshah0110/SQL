/* 2362: Generate the Invoice

Table:Products
+-------------+------+
| Column Name | Type |
+-------------+------+
| product_id  | int  |
| price       | int  |
+-------------+------+
product_id is the primary key for this table.
Each row in this table shows the ID of a product and the price of one unit.

Table:Purchases
+-------------+------+
| Column Name | Type |
+-------------+------+
| invoice_id  | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(invoice_id, product_id) is the primary key for this table.
Each row in this table shows the quantity ordered from one product in an invoice. 

Write an SQL query to show the details of the invoice with the highest price. 
If two or more invoices have the same price, return the details of the one with the smallest invoice_id.
Return the result table in any order .

Schema:
Create table If Not Exists Products (product_id int, price int);
insert into Products (product_id, price) values ('1', '100'),('2', '200');

Create table If Not Exists Purchases (invoice_id int, product_id int, quantity int);
insert into Purchases (invoice_id, product_id, quantity) values ('1', '1', '2'),
('3', '2', '1'), ('2', '2', '3'), ('2', '1', '4'), ('4', '1', '10'); */

-- Solution:
with cte as(
  select
  invoice_id, Purchases.product_id, quantity, sum(quantity*price) over(partition by invoice_id) as 'price'
  from Purchases join Products
  on Purchases.product_id = Products.product_id
)

select product_id, quantity, price
from cte
where invoice_id = (select invoice_id from cte order by price desc, invoice_id limit 1);