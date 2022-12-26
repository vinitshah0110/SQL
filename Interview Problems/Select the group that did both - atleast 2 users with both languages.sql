/* Find companies who have atleast 2 users who speaks English and German both the languages

Schema:
create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English'); */

-- Solution 1:
with cte as(
  select company_id, user_id
  from company_users
  where language in ('German','English')
  group by company_id, user_id having count(distinct language)=2
)

select company_id
from cte
group by company_id having count(distinct user_id)>1;

-- SOlution 2:
select c1.company_id
from company_users c1 join company_users c2
on c1.user_id = c2.user_id and c1.language='German' and c2.language='English'
group by c1.company_id
having count(c1.user_id)>1;