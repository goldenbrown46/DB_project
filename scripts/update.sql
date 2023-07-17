-- Обновление имени пользователя в таблице users
UPDATE buying_games_onl.users
SET user_name = 'New User Name'
WHERE user_ID = 1;

-- Обновление цены игры в определенном магазине в таблице store_games
UPDATE buying_games_onl.store_games
SET store_price = 29.99
WHERE game_ID = 3 AND store_ID = 2;

-- Обновление сайт магазина в таблице stores
UPDATE buying_games_onl.stores
SET website = 'www.newweb.com'
WHERE store_ID = 1;

-- Обновление даты публикации игры в таблице games
UPDATE buying_games_onl.games
SET publish_date = '2019-05-15'
WHERE game_ID = 4;

-- Обновление статуса скидки на игру в таблице discounts
UPDATE buying_games_onl.discounts
SET 
	state = TRUE,
	code = 'ABCD123',
	percent = 10,
	new_price = price * percent / 100,
	date_start = '2024-01-01',
	date_end = '2024-01-10'
WHERE game_ID = 1 AND store_ID = 1;

-- Обновление пароля пользователя в таблице users
UPDATE buying_games_onl.users
SET pass = 'new_password'
WHERE user_ID = 2;

-- Обновить library_history пользователя 1 по его последнему заказу
UPDATE buying_games_onl.library_history
SET dt_history = (SELECT MAX(date)
                  FROM buying_games_onl.orders
                  WHERE user_ID = 1)
WHERE user_ID = 1;
