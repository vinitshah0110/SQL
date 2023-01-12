/* PayPal SQL interview question
Given a table of bank deposits and withdrawals, return the final balance for each account

Schema:
create table account(
  transaction_id int,
  account_id int,
  transaction_type varchar(20),
  amount float
);

insert into account() values(123,101,'deposit',10.0),(124,101,'deposit',20.0),(125,101,'withdrawal',5.0),
(126,201,'deposit',20.0),(127,201,'withdrawal',10.0); 

Output:
account_id	final_balance
101	25.00
201	10.00
*/

-- Solution:
SELECT account_id, 
FORMAT(SUM(CASE WHEN transaction_type='deposit' THEN amount ELSE amount*-1 END),2) AS final_balance
FROM account
GROUP BY account_id;