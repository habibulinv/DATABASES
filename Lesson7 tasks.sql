-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине


SELECT DISTINCT id, concat(SUBSTRING(name, 1,1),'. ',surname) as name FROM users AS u
JOIN
  (SELECT DISTINCT user_id FROM orders) as f
WHERE
  u.id = f.user_id;
 
 
 -- Выведите список товаров products и разделов orders, который соответствует товару


SELECT name, o.id, o.status, o.total from products p
left join orders o
on p.id = o.goods_id
where o.id is not null
order by name;
 

-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов


drop database if exists flights_lesson7;
create database flights_lesson7;
use flights_lesson7;
DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
id serial primary key,
flights_from varchar(50),
flights_to varchar(50)
);


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
id serial primary key,
label varchar(50),
name varchar(50)
);


insert into flights (id, flights_from, flights_to) values (1, 'moscow', 'omsk');
insert into flights (id, flights_from, flights_to) values (2, 'novgorod', 'kazan');
insert into flights (id, flights_from, flights_to) values (3, 'irkutsk', 'moscow');
insert into flights (id, flights_from, flights_to) values (4, 'omsk', 'irkutsk');
insert into flights (id, flights_from, flights_to) values (5, 'moscow', 'kazan');


insert into cities (label, name) values ('moscow', 'Москва');
insert into cities (label, name) values ('irkutsk', 'Иркутск');
insert into cities (label, name) values ('novgorod', 'Новгород');
insert into cities (label, name) values ('kazan', 'Казань');
insert into cities (label, name) values ('omsk', 'Омск');

-- Решение

SELECT f.id, c.name as f_from, c2.name as f_to  from flights f
	left join cities c
	on f.flights_from = c.label
	left join cities c2
	on f.flights_to = c2.label;
