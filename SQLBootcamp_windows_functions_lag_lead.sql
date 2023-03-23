/*Write a query that can extract the following information from the "employees" database:
- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
- a column showing the previous salary from the given ordered list
- a column showing the subsequent salary from the given ordered list
- a column displaying the difference between the current salary of a certain employee and their previous salary
- a column displaying the difference between the next salary of a certain employee and their current salary
Limit the output to salary values higher than $80,000 only.
Also, to obtain a meaningful result, partition the data by employee number.*/

select emp_no,
salary,
lag(salary) over (partition by emp_no order by salary) as previous_salary,
lead(salary) over (partition by emp_no order by salary) as next_salary,
salary - lag(salary) over (partition by emp_no order by salary) as diff_prev_curr_salary,
lead(salary) over (partition by emp_no order by salary) - salary as diff_next_curr_salary
from salaries
where emp_no between 10500 and 10600 
and salary >= 80000
order by emp_no;

/* Create a query whose result set contains data arranged by the salary values associated to each employee number (in ascending order). 
Let the output contain the following six columns:
- the employee number
- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)
- the employee's previous salary
- the employee's contract salary value preceding their previous salary
- the employee's next salary
- the employee's contract salary value subsequent to their next salary
Restrict the output to the first 1000 records you can obtain.*/

select emp_no,
salary as employees_current_salary,
lag(salary) over (partition by emp_no order by salary) as previous_salary,
lag(salary, 2) over (partition by emp_no order by salary) as preceding_previous_salary,
lead(salary) over (partition by emp_no order by salary) as next_salary,
lead(salary, 2) over (partition by emp_no order by salary) as preceding_next_salary
from salaries
limit 1000;
