/* Identify delta records from a production table

Schema:
create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders values (1,'2022-10-21'),(2,'2022-10-22'),(3,'2022-10-25'),(4,'2022-10-25');

create table tbl_orders_copy as select * from tbl_orders;

insert into tbl_orders values (5,'2022-10-26'),(6,'2022-10-26');
delete from tbl_orders where order_id=1; */

with full_outer_join as(
  select tbl_orders.order_id, tbl_orders_copy.order_id as 'copy_id'
  from tbl_orders left join tbl_orders_copy
  on tbl_orders.order_id = tbl_orders_copy.order_id
  union
  select tbl_orders.order_id, tbl_orders_copy.order_id as 'copy_id'
  from tbl_orders_copy left join tbl_orders
  on tbl_orders_copy.order_id = tbl_orders.order_id
)

select ifnull(order_id,copy_id) as 'ORDER_ID',
case 
  when order_id is null then 'Delete' 
  when copy_id is null then 'Insert' 
end as 'INSERT_OR_DELETE_FLAG'
from full_outer_join
where order_id is null or copy_id is null;