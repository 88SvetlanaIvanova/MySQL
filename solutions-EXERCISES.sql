USE gringotts;
#1
SELECT
COUNT(id) as 'count'
FROM
wizzard_deposits;
---------------------------------------------------------------
#2
SELECT MAX(magic_wand_size) AS 'longest_magic_wand'
FROM wizzard_deposits;
----------------------------------------------------------
#3
SELECT deposit_group, MAX(magic_wand_size) AS 'longest_magic_wand' 
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand ASC, deposit_group ASC;

-----------------------------------------------------------------------
#4
SELECT deposit_group FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;
---------------------------------------------------------------------
#5 passed
SELECT deposit_group, SUM(deposit_amount) as 'total_sum'
FROM
wizzard_deposits
GROUP BY deposit_group
ORDER BY  total_sum ASC;
-----------------------------------------------------------------------
#6 passed
SELECT deposit_group, SUM(deposit_amount) as 'total_sum'
FROM
	wizzard_deposits
WHERE 
	magic_wand_creator LIKE 'Ollivander family'
GROUP BY deposit_group
ORDER BY  deposit_group ASC;

----------------------------------------------------------------------

#7-PASSED
SELECT deposit_group,SUM(deposit_amount) as 'total_sum'
FROM
wizzard_deposits
WHERE magic_wand_creator LIKE 'Ollivander family'

GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;
-----------------------------------------------------------------
#8 Deposit Charge - PASSED
SELECT deposit_group,  magic_wand_creator, MIN(deposit_charge) 
FROM
	wizzard_deposits
GROUP BY deposit_group,  magic_wand_creator

ORDER BY magic_wand_creator, deposit_group;

----------------------------------------------------------------
#9 - passed
SELECT
	CASE
		WHEN age <= 10 THEN '[0-10]'
		WHEN age <= 20 THEN '[11-20]'
		WHEN age <= 30 THEN '[21-30]'
		WHEN age <= 40 THEN '[31-40]'
		WHEN age <= 50 THEN '[41-50]'
		WHEN age <= 60 THEN '[51-60]'
		ELSE '[61+]'
	END AS 'age_group' ,
    COUNT(*)AS 'wizard_count'
FROM wizzard_deposits
GROUP BY age_group
ORDER BY wizard_count;
-------------------------------------------------------------------------

#10 passed
SELECT left(first_name, 1) AS first_letter
FROM
	wizzard_deposits 
    
WHERE deposit_group LIKE 'troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

----------------------------------------------------------------------------

#11-PASSED

SELECT
	deposit_group, is_deposit_expired, AVG(deposit_interest)
FROM
	wizzard_deposits
WHERE 
	deposit_start_date > '1985-01-01'

GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired ASC;
-------------------------------------------------------------------------------
#12
SELECT 
	department_id, MIN(salary) as 'minimum_salary'
FROM 
	employees
    
WHERE 
	hire_date > '2000-01-01' 
AND (department_id = 2 OR department_id = 5 OR department_id = 7) 
GROUP BY department_id
ORDER BY department_id asc;



-------------------------------------------------------------------------------

#13-passed
CREATE TABLE test(department_id INT PRIMARY KEY AUTO_INCREMENT,
avg_salary DECIMAL(19, 4)) as
SELECT department_id,  
IF (department_id = 1,
AVG(salary) + 5000, AVG(salary)) as 'avg_salary'
FROM employees
WHERE salary > 30000 AND manager_id != 42
GROUP BY department_id
ORDER BY department_id;

----------------------------------------------------------------------------
#14
SELECT 
	department_id, MAX(salary) as max_salary
FROM
	employees
GROUP BY department_id
HAVING NOT max_salary BETWEEN 30000 AND 70000
ORDER BY department_id;
-----------------------------------------------------------------------------

-------------------------------------------------------------------------------
#15 - passed

SELECT 
  COUNT(e.`salary`) AS ''
FROM `employees` AS e
WHERE manager_id IS NULL
#GROUP BY e.`department_id`
ORDER BY department_id;

-------------------------------------------------------------------------------
#16 AVG(salary)

SELECT 
    department_id,
    (SELECT DISTINCT
            salary
        FROM
            employees as e2
		WHERE e1.department_id = e2.department_id
        ORDER BY salary DESC
        LIMIT 2 , 1) AS 'third_highest_salary'
FROM
    employees as e1
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL
ORDER BY department_id;

----------------------------------------

------------------------------------------------------------------------
#17 passed
SELECT e1.first_name, e1.last_name, e1.department_id
FROM
	employees AS e1
    JOIN 
    (
    SELECT 
		e2.department_id, avg(e2.salary) as salary
	FROM 
		employees as e2
	GROUP BY 
		e2.department_id
    ) AS dep_average ON e1.department_id = dep_average.department_id
WHERE e1.salary > dep_average.salary
ORDER BY e1.department_id, e1.employee_id
LIMIT 10;
-------------------------------------------------------------------------
#18 
SELECT e1.department_id, sum(e1.salary) as total_salary
FROM
	employees AS e1
    JOIN 
    (
    SELECT 
		e2.department_id, sum(e2.salary) as total_salary
	FROM 
		employees as e2
	GROUP BY 
		e2.department_id
    ) AS dep_average ON e1.department_id = dep_average.department_id
GROUP BY e1.department_id
ORDER BY e1.department_id;
---------------------------------------------------------------------
#18
SELECT e.department_id, sum(e.salary) as total_salary
FROM `employees` AS e
GROUP BY department_id
ORDER BY `department_id`;
-------------------------------------------------------------------------



