CREATE TABLE players_coaches(
`player_id` INT ,
`coach_id` INT,


CONSTRAINT fk_maping_player
FOREIGN KEY(`player_id`)
REFERENCES players(id),

CONSTRAINT fk_maping_coaches
FOREIGN KEY(`coach_id`)
REFERENCES coaches(id),
CONSTRAINT fk_asd PRIMARY KEY (player_id, coach_id)
  

);
drop table players_coaches;

#2
insert into coaches (first_name, last_name, salary, coach_level)
SELECT first_name, last_name, salary*2, 
char_length(first_name) as coach_level
 FROM players WHERE age >= 45;
 
 #3
 update coaches as co
 set coach_level = coach_level + 1
 WHERE first_name like 'A%'
 AND co.id IN (SELECT coach_id FROM players_coaches);
 

 #4
 DELETE
 FROM players WHERE age >= 45;
 
 
 
  create SCHEMA fsd;
 
 #5
 SELECT 
 first_name, age, salary
 FROM players
 ORDER BY salary DESC;
 
 #6
 
 SELECT p.id, concat(p.first_name, ' ', p.last_name) AS full_name,
 p.age, p.`position`, p.hire_date
 FROM players AS p
 JOIN skills_data AS sd
 ON p.skills_data_id = sd.id
 WHERE
 sd.strength > 50
 AND p.`position` = 'A'
 AND p.age < 23 AND p.hire_date is null
 ORDER BY p.salary, p.age;
 
 set sql_mode = 'ONLY_FULL_GROUP_BY';
 set sql_mode = '';
 #7
 SELECT t.`name`, t.established, t.fan_base, COUNT(p.id) AS cntp
 from teams as t
 LEFT JOIN players as p
 on t.id = p.team_id
 GROUP BY t.id
 ORDER BY cntp DESC, fan_base DESC;
 #7
 SELECT t.`name`, t.established, t.fan_base,
 (SELECT COUNT(8) FROM players WHERE team_id = t.id)AS cnt
 FROM teams AS t
 ORDER BY cnt DESC, fan_base DESC;
 #Any_VALUE()
 
 
 
 #8
 select MAX(sd.speed)AS spd, t.`name` as 'town_name'
 FROM skills_data AS sd
 RIGHT JOIN players AS p ON p.skills_data_id = sd.id
 RIGHT JOIN teams as tm ON p.team_id = tm.id
 RIGHT JOIN stadiums AS s ON tm.stadium_id = s.id
 RIGHT JOIN towns AS t ON s.town_id = t.id
 WHERE tm.`name` !='Devify'
 GROUP BY t.id
 ORDER BY spd DESC, t.name;
 
 
 #9
 SELECT c.name, COUNT(p.id) as countplayers, SUM(p.salary) as total_sum_of_salaries
 FROM players as p
 RIGHT JOIN teams as tm ON p.team_id = tm.id
 RIGHT JOIN stadiums AS s ON tm.stadium_id = s.id
 RIGHT JOIN towns AS t ON s.town_id = t.id
 RIGHT JOIN countries as c on t.country_id = c.id
 GROUP BY c.name
 
 ORDER BY countplayers DESC, c.name;
 
 
 
 
 #10
 DELIMITER $$
 CREATE FUNCTION `udf_stadium_players_count` (stadiumname VARCHAR(44))
RETURNS INTEGER
DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(p.id) AS cnt
 FROM players AS p
 
 RIGHT JOIN teams AS tm ON p.team_id = tm.id
 RIGHT JOIN stadiums AS s ON tm.stadium_id = s.id
 WHERE s.name = stadiumname);
 
 
END$$
DELIMITER ;

#10
SELECT COUNT(p.id) AS cnt
 FROM players AS p
 
 RIGHT JOIN teams AS tm ON p.team_id = tm.id
 RIGHT JOIN stadiums AS s ON tm.stadium_id = s.id
 WHERE s.name = stadiumname
 ;
 
 
 #11
 DELIMITER $$
 CREATE PROCEDURE `udp_find_playmaker` (dribblingON int, teamname VARCHAR(45))
BEGIN
select  concat(p.first_name, ' ', p.last_name) AS full_name,
 age, salary, dribbling, speed , tm.name
 FROM skills_data AS sd
 
 JOIN players AS p ON p.skills_data_id = sd.id
 RIGHT JOIN teams as tm 
 ON p.team_id = tm.id
 
 WHERE tm.`name` = teamname
 AND speed > (SELECT avg(speed) from skills_data)
 AND dribbling > dribblingON
 ORDER BY sd.speed DESC
 LIMIT 1;
END$$
DELIMITER ;
 
  DELIMITER $$
 CREATE PROCEDURE `udp_find_playmaker` (dribblingON int, teamname VARCHAR(45))
BEGIN
select  concat(p.first_name, ' ', p.last_name) AS full_name,
 age, salary, dribbling, speed , tm.name
 FROM skills_data AS sd
 
 JOIN players AS p ON p.skills_data_id = sd.id
 RIGHT JOIN teams as tm 
 ON p.team_id = tm.id
 
 WHERE tm.`name` = teamname
 AND dribbling > dribblingON

 ORDER BY sd.speed DESC
 LIMIT 1;
END$$
DELIMITER ;
 
 
 
 
 
 
 