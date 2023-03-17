
-- IN and NOT IN
SELECT 
    *
FROM
    employees.employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
SELECT 
    *
FROM
    employees.employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob')

-- Like, not like

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%JACK%');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');  

-- Between 

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000; -- both numbers included in a result
   

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

   

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006'; 