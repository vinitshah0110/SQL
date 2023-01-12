/* Duplicate Job Listings [Linkedin SQL Interview Question]
Assume you are given the table below that shows job postings for all companies on the LinkedIn platform. 
Write a query to get the number of companies that have posted duplicate job listings.
Duplicate job listings refer to two jobs at the same company with the same title and description.

Schema:
CREATE TABLE job_listings (
  `job_id` INTEGER,
  `company_id` INTEGER,
  `title` VARCHAR(16),
  `description` VARCHAR(184)
);

INSERT INTO job_listings
  (`job_id`, `company_id`, `title`, `description`)
VALUES
  ('248', '827', 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
  ('149', '845', 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
  ('945', '345', 'Data Analyst', 'Data analyst reviews data to identify key insights into a businesss customers and ways the data can be used to solve problems.'),
  ('164', '345', 'Data Analyst', 'Data analyst reviews data to identify key insights into a businesss customers and ways the data can be used to solve problems.'),
  ('172', '244', 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.');

Output:
co_w_duplicate_jobs
1 */

-- Solution 1:
SELECT COUNT(job1.job_id) AS co_w_duplicate_jobs
FROM job_listings job1 JOIN job_listings job2
ON job1.company_id = job2.company_id AND job1.title = job2.title AND job1.description = job2.description
AND job1.job_id < job2.job_id;

-- Solution 2:
WITH cte AS(
 SELECT company_id
 FROM job_listings
 GROUP BY company_id,	title, description
 HAVING COUNT(job_id)>1
)

SELECT COUNT(*) AS co_w_duplicate_jobs
FROM cte;