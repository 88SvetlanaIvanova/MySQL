USE soft_uni;
#13-PASSED
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
     department_id NOT LIKE 4
ORDER BY employee_id;
-------------------------------------------------------------------------------

#14-PASSED
SELECT 
   *
FROM
    employees

ORDER BY salary DESC, first_name ASC, last_name DESC, middle_name ASC, employee_id;

----------------------------------------------------------------------------------
#15-PASSED
DROP VIEW v_employees_salaries;


CREATE VIEW v_employees_salaries  AS
SELECT 
`first_name`,
`last_name`,
`salary` 
FROM employees;

SELECT * FROM v_employees_salaries;
------------------------------------------------------------------------------------
#17-PASSED
SELECT DISTINCT
    `job_title`
FROM
    employees

ORDER BY job_title;
----------------------------------------------------------------
#18 - PASSED
SELECT
*
FROM 
projects
ORDER BY `start_date`, `name`,`project_id`
LIMIT 10;

-----------------------------------------------------------
#19 PASSED
SELECT 
    `first_name`,`last_name`, `hire_date`
FROM
    employees

ORDER BY hire_date DESC
LIMIT 7;
--------------------------------------------------------------
#21- passed
USE geography;
######
SELECT `peak_name`
FROM peaks
ORDER BY `peak_name`;
-----------------------------------------------------------------
#22-passed

SELECT `country_name`,`population`
FROM countries
WHERE `continent_code` LIKE 'EU'
ORDER BY `population`DESC, `country_name`
LIMIT 30;

------------------------------------------------------------------
USE diablo;
#24
SELECT `name`
FROM characters
ORDER BY `name`;