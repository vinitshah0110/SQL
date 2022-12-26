/* Total charges as per billing rate

Schema:
create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
insert into billings values('Sachin','1990-01-01',25)
,('Sehwag' ,'1989-01-01', 15)
,('Dhoni' ,'1989-01-01', 20)
,('Sachin' ,'1991-02-05', 30);

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values('Sachin', '1990-07-01' ,3)
,('Sachin', '1990-08-01', 5)
,('Sehwag','1990-07-01', 2)
,('Sachin','1991-07-01', 4); */

-- SOlution:
with cte as(
  select *,
  date_add( lead(bill_date,1,'2000-12-31') over(partition by emp_name), interval -1 day ) as 'end_date'
  from billings
)

select HoursWorked.emp_name, sum(bill_rate*bill_hrs) as 'total_charges'
from HoursWorked join cte
on HoursWorked.emp_name = cte.emp_name and work_date between bill_date and end_date
group by HoursWorked.emp_name;