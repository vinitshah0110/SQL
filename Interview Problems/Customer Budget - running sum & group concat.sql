/* Find how many products falls into customer budget along with list of products.
In case of clash choose the less costly product

Schema:
create table products
(
product_id varchar(20),
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);
insert into customer_budget values (100,400),(200,800),(300,1500); */

-- Solution:
with cte as(
  select product_id,
  sum(cost) over(order by product_id rows between unbounded preceding and current row) as 'cost'
  from products
)

select customer_id, budget, count(product_id) as 'no_of_products', group_concat(product_id) as 'list_of_products'
from customer_budget join cte
on cost<=budget
group by customer_id, budget;