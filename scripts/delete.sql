-- Удалить конкретную игру из таблицы store_games
DELETE FROM buying_games_onl.store_games
WHERE game_ID = 1 AND store_ID = 1;

--Удалить все игры определенного издателя из таблицы store_games
DELETE FROM buying_games_onl.store_games
WHERE publisher_ID = 1;

-- Удалить все ордера с ценой ниже определенного порога из таблицы orders
DELETE FROM buying_games_onl.orders
WHERE price < 50;

-- Удалите все магазины, в которых нет игр, перечисленных в таблице store_games
DELETE FROM buying_games_onl.stores
WHERE store_ID NOT IN (SELECT DISTINCT store_ID FROM buying_games_onl.store_games);

-- Удалить из таблицы игр все игры, опубликованные до определенной даты
DELETE FROM buying_games_onl.games
WHERE publish_date < '2010-01-01';

-- Удалить все просроченные скидки из таблицы скидок
DELETE FROM buying_games_onl.discounts
WHERE date_end < NOW();

-- Удалить пользователя и все его заказы
DELETE FROM buying_games_onl.orders  -- Сначала удалите заказы, связанные с пользователем, из таблицы заказов.
WHERE user_ID = 1;

DELETE FROM buying_games_onl.users  -- Затем удалите пользователя из таблицы пользователей.
WHERE user_ID = 1;
