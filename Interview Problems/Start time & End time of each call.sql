/* Write a query to get start time & end time of each call. Also create a column of call duration in minutes.
There will be multiple calls from one phone number and each entry in start table has a corresponding entry in end table 

Schema:
create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00');

create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00'); */

-- Solution:
with start_log as(
  select *,
  dense_rank() over(partition by phone_number order by start_time) as 'rw_start'
  from call_start_logs
)

, end_log as(
  select *,
  dense_rank() over(partition by phone_number order by end_time) as 'rw_end'
  from call_end_logs
)

select start_log.phone_number, start_log.start_time, end_log.end_time, 
round(time_to_sec(timediff(end_log.end_time,start_log.start_time))/60) as 'duration'
from start_log join end_log
on start_log.rw_start = end_log.rw_end and start_log.phone_number = end_log.phone_number;