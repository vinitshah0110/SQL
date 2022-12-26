/* Find Missing Quarter

Schema:
CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount) VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900); */

-- Solution 1:
select store, concat('Q',10-sum(right(Quarter,1))) as 'Quarter'
from STORES
group by store;

-- Solution 2:
with master as(
  select * from
  (
  (select distinct Store from STORES) a
  join
  (select distinct Quarter from STORES) b
  )
)

select master.Store, master.Quarter
from master left join STORES
on master.Store = STORES.Store and master.Quarter = STORES.Quarter
where STORES.Quarter is null
order by 1;