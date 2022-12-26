/* Write a query to find no of gold medal per swimmer for swimmer who won only gold medals

CREATE TABLE events (
ID int,
event varchar(25),
YEAR int,
GOLD varchar(25),
SILVER varchar(25),
BRONZE varchar(25)
);

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine'); */

-- Solution 1:
with cte as(
  select SILVER as 'player' from events
  union
  select BRONZE from events
)

select GOLD as 'player', count(1) as 'no_of_gold'
from events
where GOLD not in (select player from cte)
group by GOLD
order by 1;

-- Solution 2:
select e1.GOLD as 'player', count(1) as 'no_of_gold'
from events e1 left join events e2
on e1.GOLD=e2.SILVER
left join events e3
on e1.GOLD=e3.BRONZE
where e2.SILVER is null and e3.BRONZE is null
group by e1.GOLD
order by 1;