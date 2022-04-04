USE soft_uni;
#1
SELECT e.employee_id,	e.job_title, a.address_id, a.address_text

 FROM employees as e  

JOIN addresses as a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;
--------------------------------------------------------------------
#2
SELECT e.first_name,
e.last_name,
t.name AS 'town',
a.address_text

 FROM employees as e  

JOIN addresses as a ON e.address_id = a.address_id
JOIN towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;
------------------------------------------------------------------------
#3
SELECT e.employee_id, e.first_name,e.last_name, d.name AS 'department_name'
 FROM employees as e
JOIN departments as d
ON e.department_id = d.department_id
WHERE e.department_id = 3
ORDER BY e.employee_id DESC;


--------------------------------------------------------------------
#4
SELECT e.employee_id, e.first_name, e.salary, d.name
 FROM employees as e
JOIN departments as d
ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

----------------------------------------------------------------------
#5-passed

SELECT e.employee_id, e.first_name
 FROM employees as e

WHERE e.employee_id not in (SELECT s.employee_id FROM employees_projects AS s )
ORDER BY e.employee_id desc
LIMIT 3;

------------------------------------------------------------------------
#6
SELECT e.first_name,
e.last_name,
e.hire_date,
d.name as'dept_name'


FROM  employees as e

JOIN departments AS d ON e.department_id = d.department_id
WHERE DATE(e.hire_date) > '1999-01-01'
AND d.department_id =3 OR d.department_id =10
ORDER BY e.hire_date;



------------------------------------------------------------------------
#7
SELECT e.employee_id, e.first_name, p.name

FROM  employees as e
JOIN employees_projects as ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON p.project_id = ep.project_id
WHERE DATE(p.start_date) > '2002-08-13'
AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;
---------------------------------------------------------------------------------
#8
SELECT 
e.employee_id, e.first_name,
IF(p.start_date >= '2005-01-01', NULL, p.name) AS 'project_name'

 
FROM  employees as e
JOIN employees_projects as ep ON e.employee_id = ep.employee_id
JOIN projects AS p ON p.project_id = ep.project_id

WHERE ep.employee_id = 24 

ORDER BY p.name;


#8
SELECT e.employee_id, e.first_name, p.name AS project_name
FROM employees AS e
INNER JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
LEFT OUTER JOIN projects AS p
ON ep.project_id = p.project_id
AND p.start_date < '20050101'
WHERE e.employee_id = 24;

#8
SELECT e.employee_id, e.first_name,
CASE
	WHEN p.start_date > '20050101' THEN NULL
	ELSE p.name
	END AS project_name
FROM employees AS e
INNER JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
INNER JOIN projects AS p
ON ep.project_id = p.project_id
WHERE e.employee_id = 24;
----------------------------------------------------------------------------------
#9
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
 

FROM  employees as e
	JOIN
    employees as m ON e.manager_id = m.employee_id
    WHERE e.manager_id IN (3,7)
    ORDER BY e.first_name;
--------------------------------------------------------------------------------
#10
SELECT e.employee_id, 
concat_ws(' ', e.first_name, e.last_name) as 'employee name',
concat_ws(' ', m.first_name, m.last_name) as 'manager name'
, d.name

 FROM employees AS e
	JOIN
    employees as m ON e.manager_id = m.employee_id
    JOIN
    departments as d ON e.department_id = d.department_id
    ORDER BY e.employee_id
    LIMIT 5;
-------------------------------------------------------------------------------
#11
SELECT AVG(e.salary) as 'min_average_salary' FROM  employees as e 
GROUP BY e.department_id
ORDER BY `min_average_salary`
LIMIT 1;

--------------------------------------------------------------------------
#12
USE geography;

SELECT c.country_code	, m.mountain_range, 
		p.peak_name, p.elevation

 FROM countries AS c
		JOIN
    mountains_countries AS mc ON mc.country_code = c.country_code
		JOIN
    mountains AS m ON  m.id =  mc.mountain_id 
		JOIN
    peaks as p ON p.mountain_id = m.id
		WHERE 
c.country_code LIKE 'BG'
AND p.elevation > 2835
ORDER BY p.elevation DESC
;
-----------------------------------------------------------------------------
#13
SELECT 
c.country_code,
COUNT(mc.mountain_id) as 'mountain_range_count'
 FROM countries AS c
		JOIN
        mountains_countries AS mc ON c.country_code = mc.country_code
        
	GROUP BY c.country_code
    HAVING c.country_code IN ('BG','RU','US')
    ORDER BY mountain_range_count DESC
    ;
-----------------------------------------------------------------------------
#14
SELECT 	c.country_name,
	r.river_name
 FROM countries AS c
	LEFT JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
    LEFT JOIN
    rivers AS r ON r.id = cr.river_id
    JOIN
    continents AS con ON con.continent_code = c.continent_code
    WHERE con.continent_code = 'AF'
    ORDER BY c.country_name
    LIMIT 5;
-----------------------------------------------------------------------------
#15
SELECT 	c.continent_code, c.currency_code, COUNT(*) AS 'currency_usage'
 FROM 
 countries AS c
 GROUP BY c.continent_code, c.currency_code
HAVING currency_usage> 1
 AND currency_usage = (SELECT  COUNT(*) as 'most_user_curr'
FROM 
countries AS c2
WHERE 
c2.continent_code = c.continent_code
GROUP BY c2.currency_code
ORDER BY most_user_curr DESC LIMIT 1)
ORDER BY c.continent_code, c.currency_code;

---------------------------------------------------------------------------
#16
SELECT 	COUNT(c.country_name)
	
 FROM countries AS c
	 LEFT JOIN
 mountains_countries as mc on mc.country_code = c.country_code
 WHERE mc.mountain_id IS NULL;

----------------------------------------------------------------------------
# 17
SELECT country_name, MAX(p.elevation) as'highest_peak_elevation',
 MAX(r.length) as 'longest_river_length'
  FROM 
 countries AS c
 LEFT JOIN
 mountains_countries as mc on mc.country_code = c.country_code
 LEFT JOIN
 peaks AS p ON mc.mountain_id = p.mountain_id
 LEFT JOIN
 countries_rivers AS cr ON cr.country_code = c.country_code
 LEFT JOIN 
 rivers as r ON r.id = cr.river_id
 GROUP BY c.country_code
 ORDER BY highest_peak_elevation DESC
 , longest_river_length DESC, c.country_name 
 LIMIT 5;
































