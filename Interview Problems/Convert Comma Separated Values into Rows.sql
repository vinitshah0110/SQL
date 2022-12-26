/* Output the room type alonside the number of searches for it.
If the filter for room types has more than one room type, consider each unique room type as a separate row.
Sort the result based on the number of searches in descending order

Schema:
create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room'); */

-- Solution:
with cte as(
  select
  case when filter_room_types like '%entire home%' then 1 else 0 end as 'entire_home',
  case when filter_room_types like '%shared room%' then 1 else 0 end as 'shared_room',
  case when filter_room_types like '%private room%' then 1 else 0 end as 'private_room'
  from airbnb_searches
)

, room as(
  select 'entire home' as 'room_type', entire_home as 'cnt' from cte
  union all
  select 'shared room', shared_room from cte
  union all
  select 'private room', private_room from cte
)

select room_type, sum(cnt) as 'cnt'
from room
group by room_type
order by 2 desc;