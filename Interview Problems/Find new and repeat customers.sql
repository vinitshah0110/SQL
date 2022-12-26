/* Find new and repeat customers

Schema:
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000); */

-- SOlution:
with cte as(
  select *,
  min(order_date) over(partition by customer_id) as 'first_order'
  from customer_orders
)

select order_date, sum(case when order_date<=first_order then 1 else 0 end) as 'new',
count(1) - sum(case when order_date<=first_order then 1 else 0 end) as 'repeat'
from cte
group by order_date;