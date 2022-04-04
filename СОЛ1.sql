USE soft_uni;
#1
SELECT `first_name`,`last_name` 
FROM employees
WHERE lower(first_name) LIKE 'sa%'
ORDER BY employee_id;

-----------------------------------------------------------------------------------
#1
SELECT `first_name`,`last_name` 
FROM employees
WHERE first_name REGEXP '^Sa'
ORDER BY employee_id;

------------------------------------------------------------------------------------
#2
SELECT `first_name`,`last_name` 
FROM employees
WHERE lower(last_name) LIKE '%ei%'
ORDER BY employee_id;

-------------------------------------------------------------------------------------
#2
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
    LOCATE('ei', last_name)
ORDER BY employee_id;

--------------------------------------------------------------------------------------
#3
SELECT `first_name`
FROM employees
WHERE department_id IN (3,10) AND
	year(hire_date) BETWEEN 1995 AND 2005
    ORDER BY employee_id;
-------------------------------------------------------------------------------------
#6
SELECT `town_id`,`name`FROM towns
WHERE `name` REGEXP '^[MmKkBbEe]'
ORDER BY `name` ASC;
--------------------------------------------------------------------------------------
#6
SELECT `town_id`,`name`FROM towns
WHERE 
lower(`name`) LIKE 'm%' OR
lower(`name`) LIKE 'b%' OR
lower(`name`) LIKE 'k%' OR
lower(`name`) LIKE 'e%' 

ORDER BY `name` ASC;
----------------------------------------------------------------------------------------
#7
SELECT *FROM towns
WHERE `name` REGEXP '^[^RrBbDd]'
ORDER BY `name` ASC;
------------------------------------------------------------------------------------------
#7
SELECT 
    *
FROM
    towns
WHERE
    UPPER(`name`) NOT LIKE 'R%'
        AND UPPER(`name`) NOT LIKE 'B%'
        AND UPPER(`name`) NOT LIKE 'D%'
ORDER BY `name` ASC;
-----------------------------------------------------------------------------------------------
#8
CREATE VIEW test as
SELECT 
`first_name`, `last_name`
FROM
	employees
WHERE YEAR(hire_date) > 2000;
SELECT * FROM test;
------------------------------------------------------------------------------------
USE soft_uni;
#4-passed
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
     LOWER(`job_title`) NOT LIKE '%engineer%'
ORDER BY employee_id;
------------------------------------------------------------------------------------------
#5-passed
SELECT 
    `name`
FROM
    towns
WHERE char_length(name) = 5 OR
char_length(name) = 6
ORDER BY `name`;
------------------------------------------------------------------------------------------
#9-passed
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE char_length(last_name) = 5;
----------------------------------------------------------------------------------------------
USE geography;
SELECT country_name, country_code,  IF(currency_code = 'EUR', 'Euro', 'Not Euro')
FROM countries
ORDER BY country_name ASC,
country_code DESC;