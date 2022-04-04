create schema  instd ;

CREATE TABLE	users (
#– contains information about the users.
`id`INT PRIMARY KEY AUTO_INCREMENT,
 `username` VARCHAR (30)NOT NULL UNIQUE, 
 `password`VARCHAR (30)NOT NULL, 
 `email`VARCHAR (50)NOT NULL, 
 `gender` CHAR NOT NULL, 
 `age` INT NOT NULL, 
 `job_title` VARCHAR (40)NOT NULL, 
 `ip` VARCHAR (30)NOT NULL);



CREATE TABLE addresses (
#– contains information about the addresses.
`id`INT PRIMARY KEY AUTO_INCREMENT, 
`address` VARCHAR (30)NOT NULL, 
`town`VARCHAR (30)NOT NULL, 
`country`VARCHAR (30)NOT NULL, 
`user_id`INT NOT NULL,
CONSTRAINT fk_addresses_users
FOREIGN KEY (user_id)
REFERENCES users(id));

CREATE TABLE photos (
#– contains information about the photos.
`id`INT PRIMARY KEY AUTO_INCREMENT, 
`description`TEXT NOT NULL, 
`date` DATETIME NOT NULL, 
`views` int NOT NULL DEFAULT 0);


CREATE TABLE	comments (
#– contains information about the comments.
`id`INT PRIMARY KEY AUTO_INCREMENT, 
`comment` VARCHAR (255)NOT NULL, 
`date` DATETIME NOT NULL,
`photo_id`int NOT NULL,
CONSTRAINT fk_comments_photos
FOREIGN KEY(photo_id)
REFERENCES photos(id)
);

CREATE TABLE users_photos (
#– a many to many mapping table between the users and the photos.
#primary key from user_id and photo_id );
`user_id` int NOT NULL,
 `photo_id`int NOT NULL,
 CONSTRAINT fk_users_photos
 FOREIGN KEY (user_id)
 REFERENCES users(id),
 CONSTRAINT fk_photos_users
 FOREIGN KEY (photo_id)
 REFERENCES photos(id)
 );


CREATE TABLE	likes (
#– contains information about the likes.
 `id`INT PRIMARY KEY AUTO_INCREMENT, 
 `photo_id` INT, 
 `user_id`INT,
 CONSTRAINT fk_likes_photos
 FOREIGN KEY (photo_id)
 REFERENCES photos(id),
 CONSTRAINT fk_likes_users
 FOREIGN KEY (user_id)
 REFERENCES users(id)
 );
