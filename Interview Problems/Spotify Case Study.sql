/* Spotify Case Study

Schema:
CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan'); */


-- Daily active users:
select event_date, count(distinct user_id) as 'total_active_users'
from activity
group by event_date;

-- Weekly active users:
select week(event_date), count(distinct user_id) as 'total_active_users'
from activity
group by week(event_date);

-- Same day install & purchase:
with cte as(
  select a1.event_date, count(a1.event_date) as 'no_of_users'
  from activity a1 join activity a2
  on a1.user_id=a2.user_id and a1.event_name='app-purchase' and a2.event_name='app-installed' and a1.event_date=a2.event_date
  group by a1.event_date
)

select distinct activity.event_date, ifnull(no_of_users,0) as 'no_of_users'
from activity left join cte
on activity.event_date = cte.event_date;

-- Country wise percentage of paid users in India, USA & country should be tagged as others: 
with cte as(
  select user_id, event_name, 
  case 
    when country in('India','USA') then country
    else 'others' 
  end as 'country'
  from activity
)

select distinct country,
round(count(user_id) over(partition by country) / count(user_id) over()*100) as 'paid_users'
from cte
where event_name='app-purchase';

-- Among all the users who installed the app on a given day, how many did in app purchased on the very next day
with cte as(
  select a1.event_date, count(1) as 'cnt_users'
  from activity a1 join activity a2
  on a1.user_id = a2.user_id and a1.event_name='app-purchase' and a2.event_name='app-installed' 
  and datediff(a1.event_date,a2.event_date)=1
  group by a1.event_date
)

select distinct activity.event_date, ifnull(cnt_users,0) as 'cnt_users'
from activity left join cte
on activity.event_date = cte.event_date;