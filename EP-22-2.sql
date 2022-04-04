#2
insert INTO addresses(address, town, country, user_id)
SELECT u.username, u.password, u.ip, u.age
FROM users as u
WHERE u.gender = 'M';

#3
UPDATE addresses as a
SET country = (
	CASE
		WHEN country LIKE 'B%' THEN 'Blocked'
        WHEN country LIKE  'T%' THEN 'Test'
        WHEN country LIKE 'P%' THEN 'In progress'
        ELSE country
	END
);


# 4
DELETE FROM addresses 
WHERE addresses.id % 3 = 0;

#5

SELECT
u.username, u.gender, u.age
 FROM users as u
ORDER BY u.age DESC, u.username ;

#6
SELECT p.id, p.date, p.description, count(c.id) as comments_count
	FROM photos as p 
		JOIN
	comments as c ON p.id = c.photo_id
    GROUP BY p.id
    ORDER BY comments_count DESC, p.id
    LIMIT 5;
        
#7
SELECT concat_ws(" ", u.id, u.username) as id_username, email
 FROM users as u
		JOIN
	users_photos as up ON u.id = up.user_id
						AND u.id = up.photo_id
ORDER BY u.id;
        
#8
SELECT p.id, 
	count(DISTINCT l.id) as 'count_of_likes',
	count(DISTINCT c.id) as 'count_of_comments'
FROM photos as p
		left JOIN
	likes as l ON p.id = l.photo_id
		LEFT JOIN
	comments as c ON p.id = c.photo_id
GROUP BY p.id
ORDER BY count_of_likes DESC,
			count_of_comments desc,
            p.id;
            
#8
SELECT
p.`id` AS 'photo_id',
SUM(if(l.`photo_id` = p.`id`,1,0)) AS 'likes_count',
SUM(if(c.`photo_id` = p.`id`,1,0)) AS 'comments_count'
FROM `photos` AS p
LEFT JOIN `likes` AS l ON l.`photo_id` = p.`id`
LEFT JOIN `coments` AS c ON c.`photo_id` = p.`id`;


#9
SELECT concat(left(p.description, 30), '...')as 'summary',
		p.date
FROM photos as p
WHERE day(p.date)= 10
ORDER BY p.date DESC;
#GROUP BY p.id, p.date
#ORDER BY p.date;


#9
SELECT 
IF (CHAR_LENGTH(p.description)> 30, 
concat(substring(p.description from 1 for 30), '...'),p.description) 
as 'summary', p.date

FROM photos as p
WHERE day(p.date)= 10
ORDER BY p.date DESC;

#10
CREATE FUNCTION udf_users_photos_count(username VARCHAR(30)) 
RETURNS INT
RETURN(
SELECT count(*)
		FROM users as u
			JOIN
        
        users_photos as up ON u.id = up.user_id
WHERE u.username = username);
#GROUP BY u.id;

#11
DELIMITER $$
CREATE PROCEDURE `udp_modify_user` (address VARCHAR(30), town VARCHAR(30))
BEGIN
	IF((SELECT a.address
		FROM addresses AS a
        WHERE address = a.address) IS NOT NULL)
	THEN UPDATE users AS u
				JOIN
                addresses AS aa ON u.id = aa.user_id
	SET u.age = u.age + 10
		WHERE aa.address = address AND aa.town = town;
	END IF;
        


END$$
DELIMITER ;










































        
        
        














