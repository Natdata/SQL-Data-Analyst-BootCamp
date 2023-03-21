-- Create a procedure that will provide the average salary of all employees.
-- Then, call the procedure. 

USE employees;

DROP PROCEDURE IF EXISTS average_salary;

Delimiter $$
CREATE PROCEDURE average_salary()
BEGIN
       SELECT 
	   AVG(salary) AS average_salary
       FROM
	   salaries;
END $$
Delimiter ;

CALL average_salary();

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number.

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)

BEGIN
                SELECT
                      e.emp_no
                INTO p_emp_no 
                FROM
                                employees e
                WHERE
                                e.first_name = p_first_name
								AND e.last_name = p_last_name;

END$$

DELIMITER ; 