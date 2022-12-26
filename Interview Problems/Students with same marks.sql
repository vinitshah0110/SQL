/* Find students with same marks in physics and chemistry

schema:
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54); */

-- Solution 1:
select student_id
from exams
where subject in ('Chemistry', 'Physics')
group by student_id
having count(distinct subject)=2 and count(distinct marks)=1;

-- Solution 2:
select e1.student_id
from exams e1 join exams e2
on e1.student_id = e2.student_id and e1.subject<e2.subject and e1.marks=e2.marks
where e1.subject in ('Chemistry', 'Physics');