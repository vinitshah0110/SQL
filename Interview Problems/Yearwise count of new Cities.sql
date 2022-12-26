/* Business_city table has data from the day udaan has started operation.
Write a sql query to identify yearwise count of new cities where udaan started their operation

schema:
create table business_city (
business_date date,
city_id int
);

insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12); */

-- Solution:
with cte as(
  select *,
  min(year(business_date)) over(partition by city_id) as 'first_log'
  from business_city
)

select year(business_date),
sum(case when year(business_date)<=first_log then 1 else 0 end) as '#_new_cities'
from cte
group by year(business_date);