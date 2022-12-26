-- Question 177

-- Write a SQL query to get the nth highest salary from the Employee table.
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+

-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- Solution:
delimiter $$
create function getNthHighestSalary(num int) returns int DETERMINISTIC
begin
  return
  (
    select ifnull(Salary,null)
    from
      (select *,dense_rank() over(order by Salary desc) as 'rk' from Employee) temp
    where temp.rk=num
  );
end $$
delimiter ;

select getNthHighestSalary(2);