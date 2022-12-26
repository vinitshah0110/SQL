/* Write a query to populate category values to the last not null valuepopulate category values to the last not null value

Schema:
create table brands 
(
category varchar(20),
brand_name varchar(20)
);

insert into brands values('chocolates','5-star'),(null,'dairy milk'),(null,'perk'),(null,'eclair')
,('Biscuits','britannia'),(null,'good day'),(null,'boost'); */

-- Solution:
with cte as(
  select *,
  row_number() over() as 'rk'
  from brands
)

, master as(
  select *,
  lead(rk,1,999) over(order by rk) -1 as 'nxt_rk'
  from cte
  where category is not null
)

select master.category, cte.brand_name
from master join cte
on cte.rk between master.rk and master.nxt_rk;