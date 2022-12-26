/* There are 3 rows in a movie hall each with 10 seats in each row
Write a sql query to find 4 consecutive empty seats

Schema:
create table movie(
seat varchar(50),occupancy int
);
insert into movie values
('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1); */

-- Solution:
with cte as(
  select seat, left(seat,1) as 'seat_type', cast(substring(seat,2) as float) as 'row_num',
  cast(substring(seat,2) as float) - dense_rank() over(partition by left(seat,1) order by cast(substring(seat,2) as float)) as 'gap'
  from movie
  where occupancy=0
)

, con_gap as(
  select seat, seat_type,
  count(gap) over(partition by seat_type, gap) as 'cnt'
  from cte
  order by seat_type, row_num
)

select seat
from con_gap
where cnt>3;