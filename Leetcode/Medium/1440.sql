-- Question 1440

-- Table Variables:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | name          | varchar |
-- | value         | int     |
-- +---------------+---------+
-- name is the primary key for this table.
-- This table contains the stored variables and their values.
 
-- Table Expressions:
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | left_operand  | varchar |
-- | operator      | enum    |
-- | right_operand | varchar |
-- +---------------+---------+
-- (left_operand, operator, right_operand) is the primary key for this table.
-- This table contains a boolean expression that should be evaluated.
-- operator is an enum that takes one of the values ('<', '>', '=')
-- The values of left_operand and right_operand are guaranteed to be in the Variables table. 

-- Write an SQL query to evaluate the boolean expressions in Expressions table.
-- Return the result table in any order.

-- Variables table:
-- +------+-------+
-- | name | value |
-- +------+-------+
-- | x    | 66    |
-- | y    | 77    |
-- +------+-------+

-- Expressions table:
-- +--------------+----------+---------------+
-- | left_operand | operator | right_operand |
-- +--------------+----------+---------------+
-- | x            | >        | y             |
-- | x            | <        | y             |
-- | x            | =        | y             |
-- | y            | >        | x             |
-- | y            | <        | x             |
-- | x            | =        | x             |
-- +--------------+----------+---------------+

-- Result table:
-- +--------------+----------+---------------+-------+
-- | left_operand | operator | right_operand | value |
-- +--------------+----------+---------------+-------+
-- | x            | >        | y             | false |
-- | x            | <        | y             | true  |
-- | x            | =        | y             | false |
-- | y            | >        | x             | true  |
-- | y            | <        | x             | false |
-- | x            | =        | x             | true  |
-- +--------------+----------+---------------+-------+
-- As shown, you need find the value of each boolean exprssion in the table using the variables table.

-- Schema:
/* CREATE TABLE Variables (
  `name` VARCHAR(1),
  `value` INTEGER
);

INSERT INTO Variables
  (`name`, `value`)
VALUES
  ('x', '66'),
  ('y', '77');

CREATE TABLE Expressions (
  `left_operand` VARCHAR(1),
  `operator` VARCHAR(1),
  `right_operand` VARCHAR(1)
);

INSERT INTO Expressions
  (`left_operand`, `operator`, `right_operand`)
VALUES
  ('x', '>', 'y'),
  ('x', '<', 'y'),
  ('x', '=', 'y'),
  ('y', '>', 'x'),
  ('y', '<', 'x'),
  ('x', '=', 'x'); */

-- Solution:
with cte as(
  select Expressions.*, v1.value as 'x_val', v2.value as 'y_val'
  from Expressions join Variables v1
  on Expressions.left_operand = v1.name
  join Variables v2
  on Expressions.right_operand = v2.name
)

select left_operand, operator, right_operand,
case
  when operator='>' then if(x_val>y_val,true,false)
  when operator='<' then if(x_val<y_val,true,false)
  when operator='=' then if(x_val=y_val,true,false)
end as 'value'
from cte;