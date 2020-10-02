

-- Операторы, фильтрация, сортировка и ограничение

UPDATE users SET created_at=NOW(); -- Задание №1 (updated_at обновится автоматом)

UPDATE user SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE user SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE user MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE user MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; -- задание 2

SELECT phone FROM users
  ORDER BY CASE WHEN phone = 0 THEN 9999999999 ELSE phone END; -- задание №3


-- Агрегация

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS age FROM users; -- задание №1

SELECT name,birthday FROM users;
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))) AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day, COUNT(*)AS total FROM users GROUP BY day ORDER BY total DESC; -- задание №2

SELECT ROUND(EXP(SUM(LN(id)))) FROM users; -- звдвние №3


