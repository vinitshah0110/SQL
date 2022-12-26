/* Find min and max date of consecutive state

Schema:
create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success') */

-- Solution:
with cte as(
  select *,
  row_number() over(order by date_value) - dense_rank() over(partition by state order by date_value) as 'gap'
  from tasks
)

select state, min(date_value) as 'start_date', max(date_value) as 'end_date'
from cte
group by state, gap
order by 2;