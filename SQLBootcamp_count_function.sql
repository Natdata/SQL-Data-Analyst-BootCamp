-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
SELECT 
    count(*)
FROM
    salaries
WHERE
    salary >= 100.000
ORDER BY salary DESC;

-- How many managers do we have in the “empoyee” database?

SELECT 
    COUNT(*)
FROM
    dept_manager;

/*Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column. */

SELECT 
    salary, COUNT(salary) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

/*Select all employees whose average salary is higher than $120,000 per annum.*/


SELECT
   emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000; 

-- Otrzymaj listę wszystkich imion napotkanych mniej niż 200 razy.
-- Niech dane odnoszą się do osób zatrudnionych po pierwszym stycznia 1999 r.

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name desc;

 -- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
 
SELECT 
    emp_no, COUNT(emp_no)
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;


