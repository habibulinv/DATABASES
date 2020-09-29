-- CRUD
-- create INSERT
-- read SELECT
-- update UPDATE
-- delete DELETE, truncate TRUNCATE


-- INSERT ... VALUES

INSERT INTO `users` (`id`, `name`, `surname`, `email`, `phone`, `gender`, `birthday`, `hometown`, `photo_id`, `pass`, `created_at`)
VALUES ('101', 'Mae', 'McDermott', 'antwan95@example.net', '862', 'm', '1985-04-02', 'Ahmadstad', '1374', '1146809655061', '2007-09-10 21:44:17');

INSERT INTO `users` (`name`, `surname`, `email`, `phone`, `gender`, `birthday`, `hometown`, `photo_id`, `pass`)
VALUES ('Mae', 'McDermott', 'antwan95@example.net', '862', 'm', '1985-04-02', 'Ahmadstad', '1374', '1146809655061');

INSERT INTO users VALUES ('102', 'Zachariah', 'Howell', 'jake.moore@example.com', '956', 'f', '1988-10-11', 'North Zachariah', '9810523', '6016617273052', '1977-08-01 15:18:37');

-- INSERT .. SET

INSERT INTO users SET name='Владимир', surname='Хабибулин', email='hva@crystals.ru', phone='89313660890', gender='m', birthday='1989-02-26', hometown='Санкт-Петербург', photo_id='9810517', pass='747193273945';


-- INSERT .. SELECT

insert communities
select * from snet2008.communities;

insert communities (name)
select name from snet2008.communities;


-- SELECT
USE snet1509new
select surname, name, phone from users
select * from users limit 10;
select * from users limit 3 offset 8;
select * from users limit 8,3;
select concat (surname, ' ', name) persons from users;
select concat(SUBSTRING(name, 1,1),'. ',surname) persons, phone from users; -- SUBSTRING - кусок строки(имя столбца, с какого символа выводим, сколько символов после него выводим)
select concat(SUBSTRING(surname, 1,1),'. ',name) persons, SUBSTRING(email, 1,10) from users;

select hometown from users;
select DISTINCT hometown from users; -- выборка без дублей
select * from users where hometown = 'Port Maribel' -- выборка строк содержащих в каком столбце опредененный признак
select name, surname, birthday from users where birthday >= '1985-01-01' order by birthday; -- выбирать значения больше или меньше
select name, surname, birthday from users where birthday >= '1985-01-01' and birthday <= '1990-01-01' order by birthday; -- задаем промежуток
select name, surname, birthday from users where birthday between'1985-01-01' and '2000-01-01' order by birthday; -- задаем промежуток, вариант 2

select name, surname, hometown from users where hometown !='Port Maribel'; -- выборка с исключение конкретных значений
select name, surname, hometown from users where hometown <> 'Москва';
select name, surname, hometown from users where hometown in ('Port Maribel', 'Ortizport'); -- выбор по несколько параметрам в одной колонке одноверменно
select name, surname, hometown from users where hometown='Port Maribel' or hometown='Ortizport';


select name, surname from users where surname like 'M%'; -- начинается с этой буквы, %-заменяет 0 или больше знаков.
select name, surname from users where surname like '%t'; -- кончается с этой буквы, %-заменяет 0 или больше знаков.
select name, surname from users where surname like 'M%t'; -- начинается с М и кончается на t.

select name, surname, hometown, gender from users where (hometown like 'O%') and gender='f'; -- в скобках выполняется в первую очередь


select COUNT(*)from users; -- считает колво элементов
select min(birthday)from users; -- минимальное или max значение
select hometown, COUNT(*)from users group by hometown; -- группирует посчитанные значения
select hometown, COUNT(*)from users group by hometown having count(*)>=10; -- выбираем группы со значением больше 10


-- UPDATE

update friend_requests 
	set status = 'aproved'
	where initiator_user_id = 1 and target_user_id = 2;


-- TRUNCATE
select name from communities;
delete from communities where name = 'at'; -- удалить запись запись из таблицы
delete from communities where id between 1 and 10;
delete from communities;

set foreign_key_checks = 0; -- отключаем внешние ключи
truncate table communities;
set foreign_key_checks = 1;-- включаем внешние ключи

