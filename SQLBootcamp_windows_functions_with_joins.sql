/*Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 10500 and 10600 inclusive. 
Let equal salary values for one and the same employee bear the same rank. Also, allow gaps in the ranks obtained for their subsequent rows.
Use a join on the “employees” and “salaries” tables to obtain the desired result.
 */
 
 select s.emp_no,
 s.salary,
 rank() over (partition by emp_no order by salary desc) as salary_rank
 from employees e
 join salaries s
 on e.emp_no = s.emp_no
 and s.emp_no between 10500 and 10600;
 
 /*Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.*/

select s.emp_no,
s.salary,
dense_rank() over (partition by emp_no order by salary) as dense_rank_salary,
hire_date,
s.from_date
from employees e
join salaries s
on e.emp_no = s.emp_no
and s.emp_no between 10500 and 10600
and year(s.from_date) - year(e.hire_date) >= 5


 