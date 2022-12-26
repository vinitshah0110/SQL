-- Question 578

-- Get the highest answer rate question from a table survey_log with these columns: id, action, question_id, answer_id, q_num, timestamp.
-- id means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", 
-- while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

-- Write a sql query to identify the question which has the highest answer rate.

-- Input:
-- +------+-----------+--------------+------------+-----------+------------+
-- | id   | action    | question_id  | answer_id  | q_num     | timestamp  |
-- +------+-----------+--------------+------------+-----------+------------+
-- | 5    | show      | 285          | null       | 1         | 123        |
-- | 5    | answer    | 285          | 124124     | 1         | 124        |
-- | 5    | show      | 369          | null       | 2         | 125        |
-- | 5    | skip      | 369          | null       | 2         | 126        |
-- +------+-----------+--------------+------------+-----------+------------+

-- Output:
-- +-------------+
-- | survey_log  |
-- +-------------+
-- |    285      |
-- +-------------+
-- Explanation:
-- question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.
-- The highest answer rate meaning is: answer number's ratio in show number in the same question.

-- Schema:
/* CREATE TABLE survey (
  `id` INTEGER,
  `action` VARCHAR(6),
  `question_id` INTEGER,
  `answer_id` VARCHAR(6),
  `q_num` INTEGER,
  `timestamp` INTEGER
);

INSERT INTO survey
  (`id`, `action`, `question_id`, `answer_id`, `q_num`, `timestamp`)
VALUES
  ('5', 'show', '285', 'null', '1', '123'),
  ('5', 'answer', '285', '124124', '1', '124'),
  ('5', 'show', '369', 'null', '2', '125'),
  ('5', 'skip', '369', 'null', '2', '126'); */

-- Solution
with cte as(
  select question_id,
  sum(case when action='answer' then 1 else 0 end) / sum(case when action='show' then 1 else 0     end) as 'answer_rate'
  from survey
  group by question_id
)

, temp as(
  select *,
  dense_rank() over(order by answer_rate desc) as 'rk'
  from cte
)

select question_id from temp
where rk=1;