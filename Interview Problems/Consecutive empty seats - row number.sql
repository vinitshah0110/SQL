/* Three or more consecutive empty seats

Schema:
create table bms (seat_no int ,is_empty varchar(10));
insert into bms values (1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y'); */

-- Solution:
with cte as(
  select seat_no,
  seat_no - dense_rank() over(order by seat_no) as 'gap'
  from bms
  where is_empty='Y'
)

, con_gap as(
  select gap
  from cte
  group by gap having count(gap)>2
)

select seat_no
from cte
where gap in (select gap from con_gap);