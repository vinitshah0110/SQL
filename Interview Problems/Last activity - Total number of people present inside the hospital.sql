/* Write a sql query to find the total number of people present inside the hospital

Schema:
create table hospital ( 
  emp_id int, action varchar(10), time datetime
);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00'); */

-- Solution 1:
with cte as(
  select emp_id, action,
  dense_rank() over(partition by emp_id order by time desc) as 'rk'
  from hospital
)

select emp_id
from cte
where rk=1 and action='in';

-- Solution 2:
with cte as(
  select emp_id,
  max(case when action='in' then time end) as 'latest_in_time',
  ifnull(max(case when action='out' then time end),'2000-01-01 00:00:00') as 'latest_out_time'
  from hospital
  group by emp_id
)

select emp_id
from cte
where latest_in_time>latest_out_time;