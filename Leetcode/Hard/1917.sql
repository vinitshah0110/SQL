/* 1917 - Leetcodify Friends Recommendations

Write an SQL query to recommend friends to Leetcodify users. We recommend user x to user y if:
Users x and y are not friends, and
Users x and y listened to the same three or more different songs on the same day.
Note that friend recommendations are unidirectional, meaning if user x and user y should be recommended to each other, the result table 
should have both user x recommended to user y and user y recommended to user x. 
Also, note that the result table should not contain duplicates (i.e., user y should not be recommended to user x multiple times.).

Return the result table in any order.

Listens table:
+---------+---------+------------+
| user_id | song_id | day        |
+---------+---------+------------+
| 1       | 10      | 2021-03-15 |
| 1       | 11      | 2021-03-15 |
| 1       | 12      | 2021-03-15 |
| 2       | 10      | 2021-03-15 |
| 2       | 11      | 2021-03-15 |
| 2       | 12      | 2021-03-15 |
| 3       | 10      | 2021-03-15 |
| 3       | 11      | 2021-03-15 |
| 3       | 12      | 2021-03-15 |
| 4       | 10      | 2021-03-15 |
| 4       | 11      | 2021-03-15 |
| 4       | 13      | 2021-03-15 |
| 5       | 10      | 2021-03-16 |
| 5       | 11      | 2021-03-16 |
| 5       | 12      | 2021-03-16 |
+---------+---------+------------+

Friendship table:
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 2        |
+----------+----------+

Result table:
+---------+----------------+
| user_id | recommended_id |
+---------+----------------+
| 1       | 3              |
| 2       | 3              |
| 3       | 1              |
| 3       | 2              |
+---------+----------------+
Users 1 and 2 listened to songs 10, 11, and 12 on the same day, but they are already friends.
Users 1 and 3 listened to songs 10, 11, and 12 on the same day. Since they are not friends, we recommend them to each other.
Users 1 and 4 did not listen to the same three songs.
Users 1 and 5 listened to songs 10, 11, and 12, but on different days.
Similarly, users 2 and 3 listened to songs 10, 11, and 12 on the same day and are not friends, so we recommend them to each other.

Schema:
CREATE TABLE Listens (
  `user_id` INTEGER,
  `song_id` INTEGER,
  `day` DATE
);

INSERT INTO Listens
  (`user_id`, `song_id`, `day`)
VALUES
  ('1', '10', '2021-03-15'),
  ('1', '11', '2021-03-15'),
  ('1', '12', '2021-03-15'),
  ('2', '10', '2021-03-15'),
  ('2', '11', '2021-03-15'),
  ('2', '12', '2021-03-15'),
  ('3', '10', '2021-03-15'),
  ('3', '11', '2021-03-15'),
  ('3', '12', '2021-03-15'),
  ('4', '10', '2021-03-15'),
  ('4', '11', '2021-03-15'),
  ('4', '13', '2021-03-15'),
  ('5', '10', '2021-03-16'),
  ('5', '11', '2021-03-16'),
  ('5', '12', '2021-03-16');

CREATE TABLE Friendship (
  `user1_id` INTEGER,
  `user2_id` INTEGER
);

INSERT INTO Friendship
  (`user1_id`, `user2_id`)
VALUES
  ('1', '2'); */

-- Solution:
with friends as(
  select user1_id, user2_id from Friendship
  union all
  select user2_id, user1_id from Friendship
)

, b as(
  select l1.user_id as 'u1', l1.song_id as 's1', l1.day as 'd1', ifnull(user2_id,0), l2.user_id as 'u2', l2.song_id as 's2', l2.day as 'd2'
  from Listens l1 left join friends
  on user_id=user1_id
  join Listens l2
  on ifnull(user2_id,0)!=l2.user_id and l1.user_id!=l2.user_id and l1.day=l2.day and l1.song_id=l2.song_id
  order by 1
)

select u1 as 'user_id', u2 as 'recommended_id'
from b
group by u1,u2,d1
having count(distinct s1)>2;