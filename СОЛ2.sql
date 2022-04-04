USE geography;
#10
SELECT 
country_name, iso_code
FROM
countries
WHERE country_name LIKE 'a%a%a%'
ORDER BY iso_code;
#this solution does not get separate words coutries like UAE
----------------------------------------------------------------------
#10
SELECT 
country_name, iso_code
FROM
countries
WHERE 
char_length(country_name) - char_length(REPLACE(LOWER(country_name), 'a', '')) >=3
ORDER BY iso_code;
-------------------------------------------------------------------------
USE geography;
#11
SELECT 
p.peak_name, 
r.river_name, 
lower(concat(LEFT(p.peak_name,
CHAR_LENGTH(p.peak_name) - 1), r.river_name))AS mix
FROM 
peaks as p,
rivers as r
WHERE 
lower(RIGHT(p.peak_name, 1))= lower(LEFT(r.river_name, 1))
ORDER BY mix;
-----------------------------------------------------------------------------
#12-PASSED
SELECT `name`, DATE_FORMAT(`start`, "%Y-%m-%d")
FROM games
WHERE 
YEAR(`start`) = 2011 OR 
YEAR(`start`) = 2012

ORDER BY  `start`,`name` LIMIT 50;


--------------------------------------------------------------------------------
#13_passed
USE diablo;
SELECT 
	user_name, 
	REGEXP_REPLACE(email,'.*@' ,'') AS 'email provider'
FROM
	users
	ORDER BY `email provider`,user_name ASC;
    
------------------------------------------------------------------------------------
#13_passed
SELECT 
	user_name, 
	SUBSTRING(email FROM(LOCATE('@' ,email)+1)) AS 'email provider'
FROM
	users
	ORDER BY `email provider`,user_name ;
--------------------------------------------------------------------------------------
#14-PASSED
SELECT 
	user_name, ip_address 
FROM 
	users
WHERE 
	ip_address LIKE "___\.1%\.%\.___"
ORDER BY user_name ;










-----------------------------------------------------------------------------------
#15-passed
SELECT
`name` AS game,
CASE
WHEN HOUR(g.start) BETWEEN 0 AND 11 THEN 'Morning'
WHEN HOUR(g.start) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as 'Part of the Day',
CASE
WHEN g.duration <=3 THEN 'Extra Short'
WHEN g.duration BETWEEN 4 AND 6 THEN 'Short'
WHEN g.duration BETWEEN 7 AND 10 THEN'Long'
ELSE 'Extra Long'
END AS 'Duration'
FROM
games as g;
--------------------------------------------------------------------------------
#16-passed

SELECT product_name,
		order_date,
		adddate(order_date, INTERVAL 3 DAY),
        adddate(order_date, INTERVAL 1 MONTH)
FROM orders;
--------------------------------------------------------------------------------




