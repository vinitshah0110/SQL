/* Write a query to provide the date for nth occurance of sunday in future from given date

monday:0
tuesday:1
wednesday:2
thursday:3
friday:4
saturday:5
sunday:6 

first occurance:
from x to y -> daysbetween(x and y) + weekday(x)
next occurance:
7*(given-1 days) */

-- Solution:
set @today='2022-12-14';
set @n=3;

select date_add(@today, interval 6 - weekday(@today) + (@n-1)*7 day);