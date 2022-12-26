/* Derive Points table for ICC tournament

Schema:
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','draw'); */

-- Solution:
with cte as(
  select Team_1, Winner from icc_world_cup
  union all
  select Team_2, Winner from icc_world_cup
)

, result as(
  select Team_1 as 'Team_Name', 
  case when Team_1=Winner then 1 else 0 end as 'winner',
  case when Winner='draw' then 1 else 0 end as 'draw'
  from cte
)

select Team_Name, count(Team_Name) as 'Matches_Played', sum(winner) as 'no_of_wins', sum(draw) as 'no_of_draws', 
count(Team_Name) - sum(winner) - sum(draw) as 'no_of_losses'
from result
group by Team_Name;