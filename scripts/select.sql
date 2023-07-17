-- Подсчитать количество заказов для каждой игры
SELECT g.game_name, COUNT(o.order_ID) AS order_count
FROM buying_games_onl.games g
JOIN buying_games_onl.orders o ON g.game_ID = o.game_ID
GROUP BY g.game_name;

-- Найдите среднюю цену каждой игры
SELECT g.game_name, AVG(sg.store_price) AS average_price
FROM buying_games_onl.games g
JOIN buying_games_onl.store_games sg ON g.game_ID = sg.game_ID
GROUP BY g.game_name;

-- Найти все магазины, в которых есть игра Wild Hearts
SELECT s.*
FROM buying_games_onl.stores s
JOIN buying_games_onl.store_games sg ON s.store_ID = sg.store_ID
JOIN buying_games_onl.games g ON sg.game_ID = g.game_ID
WHERE g.game_name = 'Wild hearts';

-- Найдите магазин с самой низкой ценой на игру Resident Evil 4
SELECT s.store_ID, s.store_name, sg.store_price
FROM buying_games_onl.stores s
JOIN buying_games_onl.store_games sg ON s.store_ID = sg.store_ID
JOIN buying_games_onl.games g ON sg.game_ID = g.game_ID
WHERE g.game_name = 'Resident Evil 4'
ORDER BY sg.store_price ASC
LIMIT 1;

-- Подсчитайте количество игр в библиотеке каждого пользователя
SELECT u.user_ID, u.user_name, COUNT(l.game_ID) AS game_count
FROM buying_games_onl.users u
LEFT JOIN buying_games_onl.library l ON u.user_ID = l.user_ID
GROUP BY u.user_ID, u.user_name
ORDER BY user_ID;

-- Найти все игры, выпущенные до 2018 года
SELECT *
FROM buying_games_onl.games
WHERE publish_date < '2018-01-01';

-- Найдите все игры, которые продаются со скидкой, и их цены
SELECT g.game_name, s.store_name, d.new_price AS sale_price
FROM buying_games_onl.games g
JOIN buying_games_onl.store_games sg ON g.game_ID = sg.game_ID
JOIN buying_games_onl.stores s ON sg.store_ID = s.store_ID
JOIN buying_games_onl.discounts d ON g.game_ID = d.game_ID
WHERE d.state = TRUE;

--Найти магазин с наибольшим количеством заказов
SELECT s.store_name, COUNT(*) as order_count
FROM buying_games_onl.stores s
JOIN buying_games_onl.orders o ON s.store_ID = o.store_ID
GROUP BY s.store_name
ORDER BY order_count DESC
LIMIT 1;

-- Подсчитайте сумму денег, которую потратил каждый пользователь
SELECT u.user_ID, u.user_name, SUM(o.price) as total_spent
FROM buying_games_onl.users u
JOIN buying_games_onl.orders o ON u.user_ID = o.user_ID
GROUP BY u.user_ID, u.user_name
ORDER BY u.user_ID;

-- Найти пользователей, у которых пароль меньше 10 символов (слабый пароль)
SELECT user_ID, user_name, pass
FROM buying_games_onl.users
WHERE LENGTH(pass) < 10;

