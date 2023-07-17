-- Вывести список пользователей, у которых более 10 игр в библиотеке:
SELECT u.user_name, COUNT(l.game_ID) AS games_count
FROM buying_games_onl.users u
JOIN buying_games_onl.library l ON u.user_ID = l.user_ID
GROUP BY u.user_name
HAVING COUNT(l.game_ID) > 10;


-- Вывести список игр, отсортированных по дате выпуска по возрастанию:
SELECT game_name, publish_date
FROM buying_games_onl.games
ORDER BY publish_date ASC;


-- Вывести названия игр, магазинов и цен на игры в этих магазинах, а также среднюю цену игры в каждом магазине
SELECT
	game_name,
	store_name, store_price,
	AVG(store_price) OVER (PARTITION BY game_name) AS avg_price
FROM buying_games_onl.store_games
INNER JOIN buying_games_onl.games ON buying_games_onl.store_games.game_ID = buying_games_onl.games.game_ID
INNER JOIN buying_games_onl.stores ON buying_games_onl.store_games.store_ID = buying_games_onl.stores.store_ID
ORDER BY game_name, store_name;


-- Вывести имена пользователей, названия игр, даты заказа и цены за игру, ранг по убыванию цены заказа
SELECT user_name, game_name, date, price,
       DENSE_RANK() OVER (ORDER BY price DESC) AS rank
FROM buying_games_onl.orders
INNER JOIN buying_games_onl.users ON buying_games_onl.orders.user_ID = buying_games_onl.users.user_ID
INNER JOIN buying_games_onl.games ON buying_games_onl.orders.game_ID = buying_games_onl.games.game_ID
ORDER BY price DESC;


-- Вывести среднее количество продаж по магазинам за каждый месяц:
SELECT store_name, EXTRACT(MONTH FROM date) AS month,
       AVG(COUNT(*)) OVER (PARTITION BY store_ID ORDER BY EXTRACT(MONTH FROM date)) AS avg_sales
FROM buying_games_onl.orders
JOIN buying_games_onl.stores USING (store_ID)
GROUP BY store_ID, store_name, EXTRACT(MONTH FROM date)
ORDER BY store_ID, EXTRACT(MONTH FROM date);


-- Вывести даты покупок игр пользователем Huy Nguyen, а также предыдущую и следующую даты покупок в порядке возрастания даты.
SELECT user_name, game_name, date, 
       LAG(date) OVER (PARTITION BY user_name ORDER BY date) as previous_date,
       LEAD(date) OVER (PARTITION BY user_name ORDER BY date) as next_date
FROM buying_games_onl.orders
JOIN buying_games_onl.users ON orders.user_ID = users.user_ID
JOIN buying_games_onl.games ON orders.game_ID = games.game_ID
WHERE user_name = 'Huy Nguyen'
ORDER BY date ASC
