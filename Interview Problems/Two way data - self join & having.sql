/* Write a query to find PersonID, Name, number of friends, sum of marks of person who have friends with 
total score greater than 100

Schema:
CREATE TABLE friend (
  `PersonID` INTEGER,
  `FriendID` INTEGER
);
INSERT INTO friend
  (`PersonID`, `FriendID`)
VALUES
  ('1', '2'),
  ('1', '3'),
  ('2', '1'),
  ('2', '3'),
  ('3', '5'),
  ('4', '2'),
  ('4', '3'),
  ('4', '5');

CREATE TABLE person (
  `PersonID` INTEGER,
  `Name` VARCHAR(5),
  `Email` VARCHAR(21),
  `Score` INTEGER
);
INSERT INTO person
  (`PersonID`, `Name`, `Email`, `Score`)
VALUES
  ('1', 'Alice', 'alice2018@hotmail.com', '88'),
  ('2', 'Bob', 'bob2018@hotmail.com', '11'),
  ('3', 'Davis', 'davis2018@hotmail.com', '27'),
  ('4', 'Tara', 'tara2018@hotmail.com', '45'),
  ('5', 'John', 'john2018@hotmail.com', '63'); */

-- Two Way Friendship:
with cte as(
  select PersonID, FriendID from friend
  union
  select FriendID, PersonID from friend
)

, friend as(
  select person.PersonID, person.Name, cte.FriendID, p2.Score as 'friend_score'
  from person join cte
  on person.PersonID = cte.PersonID
  join person p2
  on cte.FriendID=p2.PersonID
)

select PersonID, Name, count(FriendID) as 'no_of_friends', sum(friend_score) as 'friend_score'
from friend
group by PersonID, Name
having sum(friend_score)>100;

-- One Way Friendship:
select p1.PersonID, p1.Name, count(friend.FriendID) as 'no_of_friends', sum(p2.Score) as 'friend_score'
from person p1 join friend
on p1.PersonID = friend.PersonID
join person p2
on friend.FriendID=p2.PersonID
group by p1.PersonID, p1.Name
having sum(p2.score)>100;