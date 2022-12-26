/* 2153: The Number of Passengers in Each Bus

Buses and passengers arrive at the Leetcode station. 
If a bus arrives at the station at a time tbus and a passenger arrived at a time tpassenger where tpassenger <= tbus and the passenger did not catch any bus, the passenger will use that bus.
Write an SQL query to report the number of users that used each bus.
Return the result table ordered by bus_id in ascending order.

Buses table:
+--------+--------------+
| bus_id | arrival_time |
+--------+--------------+
| 1      |            2 |
| 2      |            4 |
| 3      |            7 |
+--------+--------------+

Passengers table:
+--------------+--------------+
| passenger_id | arrival_time |
+--------------+--------------+
| 11           | 1            |
| 12           | 5            |
| 13           | 6            |
| 14           | 7            |
+--------------+--------------+

Output: 
+--------+----------------+
| bus_id | passengers_cnt |
+--------+----------------+
| 1      | 1              |
| 2      | 0              |
| 3      | 3              |
+--------+----------------+ 
- Passenger 11 arrives at time 1.
- Bus 1 arrives at time 2 and collects passenger 11.
- Bus 2 arrives at time 4 and does not collect any passengers.
- Passenger 12 arrives at time 5.
- Passenger 13 arrives at time 6.
- Passenger 14 arrives at time 7.
- Bus 3 arrives at time 7 and collects passengers 12, 13, and 14.

Schema:
CREATE TABLE Buses (
  `bus_id` INTEGER,
  `arrival_time` INTEGER
);

INSERT INTO Buses
  (`bus_id`, `arrival_time`)
VALUES
  ('1', '2'),
  ('2', '4'),
  ('3', '7');

CREATE TABLE Passengers (
  `passenger_id` INTEGER,
  `arrival_time` INTEGER
);

INSERT INTO Passengers
  (`passenger_id`, `arrival_time`)
VALUES
  ('11', '1'),
  ('12', '5'),
  ('13', '6'),
  ('14', '7'); */

-- Solution:
with first_bus as(
  select passenger_id, min(bus_id) as 'bus_id'
  from Passengers join Buses
  on Passengers.arrival_time <= Buses.arrival_time
  group by passenger_id
)

, passengers as(
  select bus_id, count(passenger_id) as 'passengers_cnt'
  from first_bus
  group by bus_id
)

select Buses.bus_id, ifnull(passengers_cnt,0) as 'passengers_cnt'
from Buses left join passengers
on Buses.bus_id = passengers.bus_id;