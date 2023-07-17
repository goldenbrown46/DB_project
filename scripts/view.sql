-- Представление для таблицы "users" с сокрытием полей "password":
CREATE OR REPLACE VIEW buying_games_onl.users_view1 AS
SELECT 
	user_ID,
	user_name,
	mail AS mail,
	LPAD('', LENGTH(pass), '*') AS pass
FROM buying_games_onl.users;


-- Представление для таблицы "users" с сокрытием полей "mail":
CREATE OR REPLACE VIEW buying_games_onl.users_view2 AS
SELECT 
	user_ID,
	user_name,
	CONCAT(LEFT(mail, 2),
           REPEAT('x', POSITION('@' IN mail) - 3),
           RIGHT(mail, LENGTH(mail) - POSITION('@' IN mail) + 1)) AS mail
FROM buying_games_onl.users;


-- Представление для таблицы "store_games" с сокрытием технических полей "store_ID":
CREATE OR REPLACE VIEW buying_games_onl.store_games_view AS
SELECT sg.game_ID, s.store_name, s.website, sg.store_price
FROM buying_games_onl.store_games sg
JOIN buying_games_onl.stores s ON sg.store_ID = s.store_ID;


-- Представление с общим количеством продаж каждого издателя по магазинам:
CREATE OR REPLACE VIEW buying_games_onl.publisher_sales AS
SELECT p.publisher_name, sg.store_ID, SUM(o.price) AS total_sales
FROM buying_games_onl.publishers p
JOIN buying_games_onl.games g
ON p.publisher_ID = g.publisher_ID
JOIN buying_games_onl.store_games sg
ON g.game_ID = sg.game_ID
JOIN buying_games_onl.orders o
ON sg.game_ID = o.game_ID AND sg.store_ID = o.store_ID
GROUP BY p.publisher_name, sg.store_ID;


-- Представление "Список игр и их цен во всех магазинах":
CREATE OR REPLACE VIEW buying_games_onl.view_game_prices AS 
SELECT 
	g.game_ID, 
	g.game_name, 
	s.store_name, 
	s.website, 
	sg.store_price 
FROM buying_games_onl.games g
JOIN buying_games_onl.store_games sg ON g.game_ID = sg.game_ID
JOIN buying_games_onl.stores s ON s.store_ID = sg.store_ID;


-- Представление, которое показывает историю покупок каждого пользователя вместе с названиями игр и ценами, которые они заплатили:
CREATE OR REPLACE VIEW buying_games_onl.purchase_history AS
SELECT u.user_name, g.game_name, o.price, o.date
FROM buying_games_onl.orders o
JOIN buying_games_onl.games g ON o.game_ID = g.game_ID
JOIN buying_games_onl.users u ON o.user_ID = u.user_ID
ORDER BY u.user_name, o.date DESC;

