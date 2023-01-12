/* 1919 Leetcodify Similar Friends
Write an SQL query to report the similar friends of Leetcodify users. A user x and user y are similar friends if:
Users x and y are friends, and
Users x and y listened to the same three or more different songs on the same day.
Return the result table in any order. 
Note that you must return the similar pairs of friends the same way they were represented in the input (always user1_id < user2_id).

Schema:
CREATE TABLE Listens (
  `user_id` INTEGER,
  `song_id` INTEGER,
  `day` DATE
);

INSERT INTO Listens
  (`user_id`, `song_id`, `day`)
VALUES
  ('1', '10', '2021-03-15'), ('1', '11', '2021-03-15'), ('1', '12', '2021-03-15'),
  ('2', '10', '2021-03-15'), ('2', '11', '2021-03-15'), ('2', '12', '2021-03-15'),
  ('3', '10', '2021-03-15'), ('3', '11', '2021-03-15'), ('3', '12', '2021-03-15'),
  ('4', '10', '2021-03-15'), ('4', '11', '2021-03-15'), ('4', '13', '2021-03-15'),
  ('5', '10', '2021-03-16'), ('5', '11', '2021-03-16'), ('5', '12', '2021-03-16');

CREATE TABLE Friendship (
  `user1_id` INTEGER,
  `user2_id` INTEGER
);

INSERT INTO Friendship
  (`user1_id`, `user2_id`)
VALUES
  ('1', '2'),
  ('2', '4'),
  ('2', '5');

Output:
user1_id	user2_id
1	2 */

-- Solution:
with cte as(
  select Listens.*, Friendship.user2_id
  from Listens left join Friendship
  on Listens.user_id = Friendship.user1_id
)

select c1.user_id as 'user1_id', c1.user2_id 
from cte c1 join cte c2
on c1.user2_id=c2.user_id and c1.day=c2.day and c1.song_id=c2.song_id
group by c1.user_id, c1.user2_id
having count(distinct c1.song_id, c1.day)>2;