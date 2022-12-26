/* Identify cities where covid cases increasing everyday

Schema:
create table covid(city varchar(50),days date,cases int);

insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);
insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);
insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);
insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400); */

-- Solution:
with cte as(
  select *,
  if(row_number() over(partition by city order by days)=dense_rank() over(partition by city order by cases),1,0) as 'flag'
  from covid
)

select city
from cte
group by city
having count(city)=sum(flag);