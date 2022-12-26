/* Phonelag table has information about caller's call history.
Write a sql query to find out callers whose first and last call was to the same person on a given day.

Schema:
create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000'); */

-- Solution:
with cte as(
  select *, date(Datecalled) as 'day',
  dense_rank() over(partition by Callerid, date(Datecalled) order by Datecalled) as 'first_log',
  dense_rank() over(partition by Callerid, date(Datecalled) order by Datecalled desc) as 'last_log'
  from phonelog
)

select Callerid, day, Recipientid
from cte
where first_log=1 or last_log=1
group by Callerid, day, Recipientid
having count(Recipientid)=2;