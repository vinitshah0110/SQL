/* Write a query to print total rides and profit rides for each driver.
Prodit ride is when the end location of current ride is same as start location on next ride

Schema:
create table drivers(
  id varchar(10), 
  start_time time, 
  end_time time, 
  start_loc varchar(10), 
  end_loc varchar(10)
);
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'), ('dri_1', '09:30', '10:30', 'b','c'),
('dri_1','11:00','11:30', 'd','e'), ('dri_1', '12:00', '12:30', 'f','g'), ('dri_1', '13:30', '14:30', 'c','h'),
('dri_2', '12:15', '12:30', 'f','g'), ('dri_2', '13:30', '14:30', 'c','h'); */

-- Solution 1:
with cte as(
  select *,
  lead(start_loc,1) over(partition by id order by start_time) as 'nxt'
  from drivers
)

select id, count(start_time) as 'total_rides', 
sum(case when end_loc=nxt then 1 else 0 end) as 'profit_rides'
from cte
group by id;

-- Solution 2:
with cte as(
  select id, start_loc, end_loc,
  dense_rank() over(partition by id order by start_time) as 'rk'
  from drivers
)

select c1.id, count(c1.id) as 'total_rides', count(c2.id) as 'profit_rides'
from cte c1 left join cte c2
on c1.id=c2.id and c1.end_loc=c2.start_loc and (c2.rk-c1.rk)=1
group by c1.id;