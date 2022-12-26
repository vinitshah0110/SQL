/* Recommendation System based on product pairs most commonly purchased together

schema:
create table orders
(
order_id int,
customer_id int,
product_id int
);
insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E'); */

-- Solution:
with cte as(
  select order_id, customer_id, product_id, name
  from orders join products
  on product_id = id
)

select concat(c1.name,' ',c2.name) as 'pair', count(1) as 'purchase_flag'
from cte c1 join cte c2
on c1.customer_id = c2.customer_id and c1.product_id<c2.product_id and c1.order_id=c2.order_id
group by concat(c1.name,' ',c2.name);