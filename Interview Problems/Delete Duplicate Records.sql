-- Schema: non-pure duplicate
create table employee(
  id int,
  emp_name varchar(20),
  salary int,
  join_date timestamp
);
insert into employee() values(1,'ishan',10000,'2023-01-03 11:17:20'),(2,'rohit',20000,'2023-01-03 11:17:50'),
(3,'virat',15000,'2023-01-03 11:18:20'),(2,'rohit',20000,'2023-01-03 11:20:50');


-- Delete without temp table
delete from employee where (id,join_date) in
(
select * from
(select id, max(join_date) as 'join_date' from employee
group by id having count(id)>1) temp
);


-- Delete with temp table
create table emp_copy as select * from employee;

delete from employee where (id,join_date) in
( select id, max(join_date) as 'join_date' from emp_copy
group by id having count(id)>1 ); 


-- Insert distinct records from temp table
delete from employee;

insert into employee
select id,emp_name,salary,join_date from
 (select *, row_number() over(partition by id order by join_date) as 'rn' 
 from emp_copy) temp
where rn=1;


-- Schema: Pure Duplicate
create table employee(
  id int,
  emp_name varchar(20),
  salary int,
  join_date timestamp
);
insert into employee() values(1,'ishan',10000,'2023-01-02'),(2,'rohit',20000,'2023-01-03 '),
(3,'virat',15000,'2023-01-03'),(2,'rohit',20000,'2023-01-03');


-- Insert distinct records from temp table
create table emp_copy as select * from employee;
delete from employee;

insert into employee select distinct * from emp_copy;