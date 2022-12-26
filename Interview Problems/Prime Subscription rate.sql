/* Prime Subscription rate by product action
Given two tabels, return the fraction of users, rounded to two decimal places, 
who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up

Schema:
create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users values (1, 'Jon', CAST('2020-2-14' AS date)), 
(2, 'Jane', CAST('2020-2-14' AS date)), 
(3, 'Jill', CAST('2020-2-15' AS date)), 
(4, 'Josh', CAST('2020-2-15' AS date)), 
(5, 'Jean', CAST('2020-2-16' AS date)), 
(6, 'Justin', CAST('2020-2-17' AS date)),
(7, 'Jeremy', CAST('2020-2-18' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);
insert into events values (1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('2020-3-2' AS date)), 
(2, 'P', CAST('2020-3-12' AS date)),
(3, 'Music', CAST('2020-3-15' AS date)), 
(4, 'Music', CAST('2020-3-15' AS date)), 
(1, 'P', CAST('2020-3-16' AS date)), 
(3, 'P', CAST('2020-3-22' AS date)); */

-- SOlution:
with cte as(
  select events.*, users.join_date,
  min(type) over(partition by events.user_id) as 'music_check'
  from events join users
  on events.user_id = users.user_id
  where type in ('Music', 'P')
)

select
round(sum(case when type='P' and datediff(access_date,join_date)<31 then 1 else 0 end) / sum(case when type='Music' then 1 else 0 end),2) as 'prime_rate'
from cte
where music_check='Music';