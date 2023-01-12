/* Given a table of candidates and their skills, you want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
Write a query to list the candidates who possess all of the required skills for the job. 
Sort the the output by candidate ID in ascending order.

Schema:
CREATE TABLE candidates (
  `candidate_id` INTEGER,
  `skill` VARCHAR(10)
);
INSERT INTO candidates
  (`candidate_id`, `skill`)
VALUES
  ('123', 'Python'),
  ('123', 'Tableau'),
  ('123', 'PostgreSQL'),
  ('234', 'R'),
  ('234', 'PowerBI'),
  ('234', 'SQL Server'),
  ('345', 'Python'),
  ('345', 'Tableau');

Output:
candidate_id
123 */

-- Solution:
SELECT candidate_id
FROM candidates
WHERE skill IN('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill)=3;