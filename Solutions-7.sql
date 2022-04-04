SET GLOBAL log_bin_trust_function_creators = 1;
SET SQL_SAFE_UPDATES = 0;
-----------------------------------------------
#1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT e.first_name, e.last_name 
FROM employees as e
WHERE e.salary > 35000
ORDER BY e.first_name, e.last_name, e.employee_id; 

END $$
DELIMITER ;
CALL usp_get_employees_salary_above_35000();
DROP PROCEDURE usp_get_employees_salary_above_35000;
-----------------------------------------------------------
#2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (salary_limit DOUBLE(19,4))
BEGIN
	SELECT e.first_name, e.last_name 
	FROM employees as e
	WHERE e.salary >= salary_limit 
	ORDER BY e.first_name, e.last_name,  e.employee_id;  


END $$
DELIMITER ;
CALL usp_get_employees_salary_above (45000);
DROP PROCEDURE usp_get_employees_salary_above; 
-------------------------------------------------------------------
#3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (town_name_start TEXT)
BEGIN
	SELECT t.name
    FROM towns AS t
    WHERE t.name LIKE CONCAT(town_name_start , '%')
    ORDER BY t.name;

END $$
DELIMITER ;
----------------------------------------------------------------------
#4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (town_name TEXT)
BEGIN
	SELECT e.first_name, e.last_name 
    
    FROM employees AS e
		JOIN 
    addresses AS a ON e.address_id = a.address_id
		JOIN
	towns AS t ON t.town_id = a.town_id
    WHERE t.name = town_name
    ORDER BY e.first_name, e.last_name,  e.employee_id;  
END $$
DELIMITER ;
DROP PROCEDURE usp_get_employees_from_town;

------------------------------------------------------------
#5

CREATE FUNCTION ufn_get_salary_level (salary DOUBLE (19,4))
RETURNS VARCHAR(7)

RETURN(CASE 
	WHEN salary < 30000 THEN 'Low'
	WHEN salary <= 50000 THEN 'Average'
    ELSE 'High'
END);
-- $$


DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (salary_level VARCHAR(7))
BEGIN
	SELECT  e.first_name, e.last_name 
    
    FROM employees AS e
	WHERE ufn_get_salary_level (e.salary) = salary_level
    ORDER BY e.first_name DESC, e.last_name DESC;


END$$
DELIMITER ;
CALL usp_get_employees_by_salary_level('High');
----------------------------------------------------------------------------------------
#7
DROP PROCEDURE  usp_get_employees_by_salary_level;

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BIT
RETURN word REGEXP(concat('^[',set_of_letters,']+$'));
---------------------------------------------------------------------------
#9
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than (money DECIMAL(19,4))
begin
	SELECT  ah.first_name, ah.last_name 
    FROM account_holders AS ah
		RIGHT JOIN 
	accounts AS a ON ah.id = a.account_holder_id
    GROUP BY ah.id
    HAVING SUM(balance) > money
    ORDER BY ah.id;

end$$
DELIMITER ;

#---------------------------------------------------------------------------
#10
DELIMITER $$
CREATE FUNCTION  ufn_calculate_future_value(initial_sum DECIMAL(19,4)
, interest_rate DECIMAL(19,4), years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	RETURN initial_sum * POW((1 + interest_rate), years);


END 
$$
DELIMITER ;
drop function ufn_calculate_future_value;
drop procedure usp_calculate_future_value_for_account; 
drop database soft_uni;
#------------------------------------------------------------------------
#11
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account (account_id INT, interest_rate DECIMAL(19,4))
BEGIN
	SELECT 
    a.id as 'account_id', 
    ah.first_name, 
    ah.last_name, 
    a.balance as 'current_balance',
    ufn_calculate_future_value(a.balance, interest_rate, 5 ) as 'balance_in_5_years'
    FROM account_holders AS ah
			JOIN 
		accounts AS a ON ah.id = a.account_holder_id
	WHERE a.id = account_id;
	
END
$$
DELIMITER ;

CALL usp_calculate_future_value_for_account(1, 0.1);

#-------------------------------------------------------------------------------
#15
CREATE TABLE `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT, 
account_id INT NOT NULL, 
old_sum DECIMAL(19,4) NOT NULL, 
new_sum DECIMAL(19,4) NOT NULL
);


DELIMITER $$
CREATE TRIGGER tr_balance_updated
AFTER UPDATE ON accounts
FOR EACH ROW 
BEGIN
	IF        OLD.balance <> NEW.balance THEN
		INSERT INTO `logs`(account_id, old_sum, new_sum)
		VALUES (OLD.id, OLD.balance, NEW.balance);
        END IF;
END $$
DELIMITER ;


#16 -- new-after: before-old
CREATE TABLE notification_emails(
`id`INT PRIMARY KEY AUTO_INCREMENT,
`recipient`INT NOT NULL, 
`subject` VARCHAR(50) NOT NULL, 
`body`VARCHAR(255) NOT NULL);

DELIMITER $$
CREATE TRIGGER tr_notifications_emails
AFTER INSERT ON `logs`
FOR EACH ROW
BEGIN
INSERT INTO notification_emails(`recipient`,`subject`, `body` )
	VALUES (
    NEW.account_id,
    concat('Balance change for account: ', new.account_id),
     concat('On ',DATE_FORMAT (NOW(), '%b %d %Y at %r'),
    ' your balance was changed from ',
   ROUND (NEW.old_sum,2),
    ' to ',
    ROUND(NEW.new_sum,2),
    '.')
    );
END$$


DELIMITER ;

