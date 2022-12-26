/* ON OFF Problem

Schema:
create table event_status
(
event_time varchar(10),
status varchar(10)
);

insert into event_status values ('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),
('10:08','on'),('10:09','off'),('10:11','on'),('10:12','off'); */

-- Solution:
with cte as(
  select event_time,
  right(event_time,2) - dense_rank() over(order by right(event_time,2)) as 'gap'
  from event_status
)

select min(event_time) as 'login', max(event_time) as 'logout', count(1) as 'cnt'
from cte
group by gap;