/* Group Concat

Schema:
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10)
);

insert into entries values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR'); */

-- Solution:
with cte as(
  select name, floor,
  dense_rank() over(order by count(floor) desc) as 'rk'
  from entries
  group by name, floor
)

select a.*,b.floor as 'most_visited_floor' from
(
(select name, count(1) as 'total_visits', group_concat(distinct resources) as 'resources used'
from entries
group by name) a
join
(select name, floor from cte where rk=1) b
on a.name=b.name
);