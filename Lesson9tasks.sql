
-- homework "Практическое задание по теме “Администрирование MySQL”

-- Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop

DROP USER shop_read;
DROP USER shop;


GRANT SELECT ON lesson6 TO shop_read;
GRANT ALL ON lesson6 TO shop;


-- homework "Практическое задание по теме “Транзакции, переменные, представления”

-- 1)В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции

SELECT * from shop.users where id=1;

START TRANSACTION;
INSERT INTO sample.users SELECT * from shop.users where id=1;
DELETE * from shop.users where id=1;
COMMIT;


-- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW prod_cat AS SELECT p.name product, c.name cat_name
from products p
join catalogs c
on p.catalog_id = c.id;


SELECT * FROM prod_cat where cat_name='Процессоры';


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

DROP PROCEDURE IF EXISTS hello;
CREATE PROCEDURE hello ()
begin
	IF CURTIME() BETWEEN '06.00.00' and '12.00.00' THEN 
		SELECT 'Доброе утро';
	ELSEIF CURTIME() BETWEEN '12.00.00' and '18.00.00' THEN
		SELECT 'Добрый день';
	ELSEIF CURTIME() BETWEEN '18.00.00' and '00.00.00' THEN
		SELECT 'Добрый вечер';
	ELSEIF CURTIME() BETWEEN '00.00.00' and '06.00.00' THEN
		SELECT 'Доброй ночи';
	END IF;
end

CALL hello();


-- 2) В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию


DROP TRIGGER IF EXISTS oneNullOnly;
CREATE TRIGGER oneNullOnly BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF (NEW.name) is NULL AND NEW.description is NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Name and description can not be NULL';
	END IF;
END






