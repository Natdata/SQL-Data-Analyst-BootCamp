/* Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database 
(regardless of their department).
Let the numbering disregard the department the managers have worked in. 
Also, let it start from the value of 1. 
Assign that value to the manager with the lowest employee number.*/

select emp_no, dept_no,
row_number() over (partition by dept_no order by emp_no) as row_num
from dept_manager;

/* Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table. 
Partition the data by the employee's first name and order it by their last name in ascending order (for each partition).*/

select emp_no, first_name, last_name,
row_number() over (partition by first_name order by last_name) as rn
from employees;

/* Find out the lowest salary value each employee has ever signed a contract for. 
To obtain the desired output, use a subquery containing a window function, 
as well as a window specification introduced with the help of the WINDOW keyword.*/

select 
emp_no,
min(salary) over (partition by emp_no order by emp_no) as min_salary
from salaries
group by emp_no;

/* Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest.*/

select emp_no, salary,
row_number() over (partition by salary order by salary desc) as rn,
rank() over (partition by emp_no order by salary desc) as salary_ranking,
dense_rank() over (partition by emp_no order by salary desc) as dense_ranking
from salaries
where emp_no = 10560