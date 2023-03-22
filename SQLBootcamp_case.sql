/* Obtain a result set containing the employee number, first name, and last name of all employees 
with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, 
according to the data provided in the dept_manager table, or a regular employee. */

SELECT 
    emp_no, 
    first_name, 
    last_name,
    case when emp_no in (select emp_no from dept_manager) then 'Manager'
    else 'Employee'
    end Title
FROM
    employees
-- left join dept_manager dm
-- on dm.emp_no = e.emp_no
where emp_no > 109990;

/*Extract a dataset containing the following information about the managers: employee number, first name, and last name. 
Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT.*/

SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name,
    max(s.salary) - min(s.salary) as salary_difference,
    case when (max(s.salary) - min(s.salary)) > 30000 then 'Hire than 30000'
    else 'NOT'
    end salary_raise
FROM
    employees e
join dept_manager dm
on e.emp_no = dm.emp_no
join salaries s
on dm.emp_no = s.emp_no
group by e.emp_no


SELECT 
    emp_no,
    MAX(salary) - MIN(salary) AS salary_difference,
    CASE
        WHEN (MAX(salary) - MIN(salary)) > 30000 THEN 'Hire than 30000'
        ELSE 'NOT'
    END salary_raise
FROM
    salaries
GROUP BY emp_no