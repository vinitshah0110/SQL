-- Question 1149

-- Table: Views
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.
 
-- Write an SQL query to find all the people who viewed more than one article on the same date, sorted in ascending order by their id.

-- Views table:
-- +------------+-----------+-----------+------------+
-- | article_id | author_id | viewer_id | view_date  |
-- +------------+-----------+-----------+------------+
-- | 1          | 3         | 5         | 2019-08-01 |
-- | 3          | 4         | 5         | 2019-08-01 |
-- | 1          | 3         | 6         | 2019-08-02 |
-- | 2          | 7         | 7         | 2019-08-01 |
-- | 2          | 7         | 6         | 2019-08-02 |
-- | 4          | 7         | 1         | 2019-07-22 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- +------------+-----------+-----------+------------+

-- Result table:
-- +------+
-- | id   |
-- +------+
-- | 5    |
-- | 6    |
-- +------+

-- Schema:
/* CREATE TABLE Views (
  `article_id` INTEGER,
  `author_id` INTEGER,
  `viewer_id` INTEGER,
  `view_date` DATE
);

INSERT INTO Views
  (`article_id`, `author_id`, `viewer_id`, `view_date`)
VALUES
  ('1', '3', '5', '2019-08-01'),
  ('3', '4', '5', '2019-08-01'),
  ('1', '3', '6', '2019-08-02'),
  ('2', '7', '7', '2019-08-01'),
  ('2', '7', '6', '2019-08-02'),
  ('4', '7', '1', '2019-07-22'),
  ('3', '4', '4', '2019-07-21'),
  ('3', '4', '4', '2019-07-21'); */

-- Solution 1:
with cte as(
  select *,
  dense_rank() over(partition by viewer_id, view_date order by article_id) as 'rk'
  from Views
)

select distinct viewer_id 
from cte
where rk>1;

-- Solution 2:
select distinct viewer_id
from Views
group by viewer_id, view_date
having count(distinct article_id)>1
order by 1;