mcbookair=# CREATE DATABASE pintagram;
CREATE DATABASE

mcbookair=# \c pintagram
You are now connected to database "pintagram" as user "mcbookair".

pintagram=# CREATE TABLE users(
pintagram(# id SERIAL PRIMARY KEY, first_name VARCHAR(50), password INTEGER);
CREATE TABLE

pintagram=# CREATE TABLE images(
id SERIAL PRIMARY KEY, url VARCHAR(50),users_id INTEGER, foreign key (users_id) REFERENCES users(id));
CREATE TABLE

pintagram=# CREATE TABLE likes(
id SERIAL PRIMARY KEY, images_id INTEGER REFERENCES images(id));
CREATE TABLE

pintagram=# CREATE TABLE tags(
pintagram(# id SERIAL PRIMARY KEY, tag VARCHAR(50));
CREATE TABLE

pintagram=# CREATE TABLE image_tag(
image_id INTEGER, tag_id INTEGER, foreign key (image_id) REFERENCES images(id), foreign key (tag_id) REFERENCES tags(id));
CREATE TABLE

pintagram=# INSERT INTO users (first_name, password) VALUES ('JUAN', 1234);
INSERT 0 1
pintagram=# INSERT INTO users (first_name, password) VALUES ('JOSE', 5678);
INSERT 0 1
pintagram=# INSERT INTO users (first_name, password) VALUES ('PEDRO', 9876);
INSERT 0 1

pintagram=# select * from users;
 id | first_name | password
----+------------+----------
  1 | JUAN       |     1234
  2 | JOSE       |     5678
  3 | PEDRO      |     9876
(3 rows)

pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images.jpg',1)
;
INSERT 0 1

pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images1.jpg',1)
;
INSERT 0 1

pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images.jpg',2)
;
INSERT 0 1
pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images1.jpg',2)
;
INSERT 0 1

pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images.jpg',3)
;
INSERT 0 1
pintagram=# INSERT INTO images (url, users_id) VALUES ('http//images1.jpg',3)
;
INSERT 0 1

pintagram=# select * from images;
 id |        url        | users_id
----+-------------------+----------
  1 | http//images.jpg  |        1
  2 | http//images1.jpg |        1
  3 | http//images.jpg  |        2
  4 | http//images1.jpg |        2
  5 | http//images.jpg  |        3
  6 | http//images1.jpg |        3
(6 rows)

pintagram=# INSERT INTO likes (images_id, user_id) VALUES (1,1);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (2,1);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (3,1);
INSERT 0 1

pintagram=# INSERT INTO likes (images_id, user_id) VALUES (4,2);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (5,2);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (6,2);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (1,3);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (3,3);
INSERT 0 1
pintagram=# INSERT INTO likes (images_id, user_id) VALUES (6,3);
INSERT 0 1

pintagram=# SELECT * FROM LIKES;
 id | images_id | user_id
----+-----------+---------
  1 |         1 |       1
  2 |         2 |       1
  3 |         3 |       1
  4 |         4 |       2
  5 |         5 |       2
  6 |         6 |       2
  7 |         1 |       3
  8 |         3 |       3
  9 |         6 |       3
(9 rows)

pintagram=# INSERT INTO tags (tag) VALUES ('AUTO');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('BICICLETA');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('MONO');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('CARRETON');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('AVION');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('TRICICLO');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('MOTO');
INSERT 0 1
pintagram=# INSERT INTO tags (tag) VALUES ('TANQUE');
INSERT 0 1

pintagram=# select * from tags;
 id |    tag
----+-----------
  1 | AUTO
  2 | BICICLETA
  3 | MONO
  4 | CARRETON
  5 | AVION
  6 | TRICICLO
  7 | MOTO
  8 | TANQUE
(8 rows)


pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (1,1);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (5,8);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (2,7);
INSERT 0 1
pintagram=# select * from image_tag;
 image_id | tag_id
----------+--------
        1 |      1
        5 |      8
        2 |      7
(3 rows)
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (2,4);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (2,5);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (5,1);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (5,6);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (2,3);
INSERT 0 1
pintagram=# INSERT INTO image_tag(image_id, tag_id) VALUES (2,4);
INSERT 0 1
pintagram=# select * from image_tag;
 image_id | tag_id
----------+--------
        1 |      1
        5 |      8
        2 |      7
        2 |      4
        2 |      5
        5 |      1
        5 |      6
        2 |      3
        2 |      4
(9 rows)

pintagram=#

pintagram=# select url, count (*) from images, likes where images.id = likes.images_id group by url;
        url        | count
-------------------+-------
 http//images.jpg  |     5
 http//images1.jpg |     4
(2 rows)

pintagram=# select first_name, url  from images, users where images.users_id = users.id;
 first_name |        url
------------+-------------------
 JUAN       | http//images.jpg
 JUAN       | http//images1.jpg
 JOSE       | http//images.jpg
 JOSE       | http//images1.jpg
 PEDRO      | http//images.jpg
 PEDRO      | http//images1.jpg
(6 rows)

pintagram=# select tag, count(*) from image_tag, tags where tags.id = image_tag.tag_id GROUP BY tag;
   tag    | count
----------+-------
 AVION    |     1
 AUTO     |     2
 MONO     |     1
 MOTO     |     1
 TANQUE   |     1
 CARRETON |     2
 TRICICLO |     1
(7 rows)
