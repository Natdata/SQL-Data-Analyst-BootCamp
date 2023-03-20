-- Subquery

-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

select * 
from dept_manager
where emp_no in
(select emp_no
from employees
where hire_date between '1990-01-01' and '1995-01-01'
order by hire_date);

-- Select the entire information for all employees whose job title is “Assistant Engineer'

SELECT 
    e.*,
    t.title
FROM
    employees e
    join titles t
    on t.emp_no = e.emp_no
    
where t.title = 'Assistant Engineer';

/* Przypisz pracownika numer 110022 jako menedżera dla wszystkich pracowników od 10001-10020 oraz
pracownika 100039 jako menedżera dla wszystkich pracowników od 10021 do 10040*/

SELECT 
    emp_no,
    (SELECT 
            emp_no
        FROM
            employees
        WHERE
            emp_no = 110022) AS manager
FROM
    employees
WHERE
    emp_no BETWEEN 10001 AND 10020 
UNION SELECT 
    emp_no,
    (SELECT 
            emp_no
        FROM
            employees
        WHERE
            emp_no = 110039) AS manager
FROM
    employees
WHERE
    emp_no BETWEEN 10021 AND 10040

