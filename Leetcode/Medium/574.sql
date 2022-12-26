-- Question 574

-- Table: Candidate
-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  

-- Table: Vote
-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.

-- Write a sql to find the name of the winning candidate, the above example will return the winner B.
-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+
-- You may assume there is no tie, in other words there will be only one winning candidate

-- Schema:
/* CREATE TABLE Candidate (
  `id` INTEGER,
  `Name` VARCHAR(1)
);

INSERT INTO Candidate
  (`id`, `Name`)
VALUES
  ('1', 'A'),
  ('2', 'B'),
  ('3', 'C'),
  ('4', 'D'),
  ('5', 'E');

CREATE TABLE Vote (
  `id` INTEGER,
  `CandidateId` INTEGER
);

INSERT INTO Vote
  (`id`, `CandidateId`)
VALUES
  ('1', '2'),
  ('2', '4'),
  ('3', '3'),
  ('4', '2'),
  ('5', '5'); */

-- Solution
with cte as(
  select Name,
  dense_rank() over(order by count(CandidateId) desc) as 'rk'
  from Vote join Candidate
  on Vote.CandidateId = Candidate.id
  group by Name
)

select Name
from cte
where rk=1;