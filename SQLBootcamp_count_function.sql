-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
SELECT 
    count(*)
FROM
    salaries
WHERE
    salary >= 100.000
ORDER BY salary DESC;

-- How many managers do we have in the “empoyee” database?

select count(*) from dept_manager;