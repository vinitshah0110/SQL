/* Write a sql query to find business day between create date and resolved date by excluding weekends and public holidays

Schema:
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
insert into tickets values
(1,'2022-08-01','2022-08-03'), (2,'2022-08-01','2022-08-12'), (3,'2022-08-01','2022-08-16');

create table holidays
(
holiday_date date
,reason varchar(100)
);
insert into holidays values('2022-08-11','Rakhi'), ('2022-08-15','Independence day'); */

-- Solution:
select distinct create_date, resolved_date,
datediff(resolved_date,create_date) - (week(resolved_date)-week(create_date))*2 - count(reason) over(partition by ticket_id) as 'business_days'
from tickets left join holidays
on holiday_date between create_date and resolved_date
and dayname(holiday_date) not in('Saturday','Sunday');