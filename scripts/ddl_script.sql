CREATE SCHEMA IF NOT EXISTS buying_games_onl;
DROP SCHEMA IF EXISTS buying_games_onl CASCADE;

CREATE TABLE IF NOT EXISTS buying_games_onl.users (
	user_ID SERIAL PRIMARY KEY,
	user_name VARCHAR(225) NOT NULL,
	mail VARCHAR(225) UNIQUE NOT NULL,
	pass VARCHAR(225) NOT NULL
);
DROP TABLE buying_games_onl.users;

CREATE TABLE IF NOT EXISTS buying_games_onl.stores (
	store_ID SERIAL PRIMARY KEY,
	store_name VARCHAR(225) UNIQUE NOT NULL,
	website VARCHAR(225) UNIQUE NOT NULL
);
DROP TABLE buying_games_onl.stores;

CREATE TABLE IF NOT EXISTS buying_games_onl.publishers (
	publisher_ID SERIAL PRIMARY KEY,
	publisher_name VARCHAR(225) UNIQUE NOT NULL
);
DROP TABLE buying_games_onl.publishers;

CREATE TABLE IF NOT EXISTS buying_games_onl.games (
	game_ID SERIAL PRIMARY KEY,
	game_name varchar(225) NOT NULL,
	publish_date DATE NOT NULL,
	publisher_ID SERIAL NOT NULL,
	FOREIGN KEY (publisher_ID) REFERENCES buying_games_onl.publishers(publisher_ID)
);
DROP TABLE buying_games_onl.games;

CREATE TABLE IF NOT EXISTS buying_games_onl.store_games (
	game_ID SERIAL NOT NULL,
	store_ID SERIAL NOT NULL,
	store_price FLOAT NOT NULL,
	FOREIGN KEY (game_ID) REFERENCES buying_games_onl.games(game_ID),
	FOREIGN KEY (store_ID) REFERENCES buying_games_onl.stores(store_ID)
);
DROP TABLE buying_games_onl.store_games;

CREATE TABLE IF NOT EXISTS buying_games_onl.orders (
	order_ID SERIAL PRIMARY KEY,
	user_ID SERIAL NOT NULL,
	date TIMESTAMP NOT NULL,
	store_ID SERIAL NOT NULL,
	game_ID SERIAL NOT NULL,
	price FLOAT NOT NULL,
	FOREIGN KEY (user_ID) REFERENCES buying_games_onl.users(user_ID),
	FOREIGN KEY (store_ID) REFERENCES buying_games_onl.stores(store_ID),
	FOREIGN KEY (game_ID) REFERENCES buying_games_onl.games(game_ID)
);
DROP TABLE buying_games_onl.orders;

CREATE TABLE IF NOT EXISTS buying_games_onl.library (
	user_ID SERIAL NOT NULL,
	game_ID SERIAL NOT NULL,
	FOREIGN KEY (user_ID) REFERENCES buying_games_onl.users(user_ID),
	FOREIGN KEY (game_ID) REFERENCES buying_games_onl.games(game_ID)
);
DROP TABLE buying_games_onl.library;

CREATE TABLE IF NOT EXISTS buying_games_onl.library_history (
	user_ID SERIAL NOT NULL,
	game_ID SERIAL NOT NULL,
	dt_history TIMESTAMP,
	FOREIGN KEY (user_ID) REFERENCES buying_games_onl.users(user_ID),
	FOREIGN KEY (game_ID) REFERENCES buying_games_onl.games(game_ID)
);
DROP TABLE buying_games_onl.library_history;

CREATE TABLE IF NOT EXISTS buying_games_onl.discounts (
	code VARCHAR(20) PRIMARY KEY,
	game_ID SERIAL NOT NULL,
	store_ID SERIAL NOT NULL,
	state BOOLEAN DEFAULT FALSE,
	price FLOAT NOT NULL,
	percent INTEGER DEFAULT 0,
	new_price FLOAT NOT NULL,
	date_start TIMESTAMP,
	date_end TIMESTAMP,
	FOREIGN KEY (game_ID) REFERENCES buying_games_onl.games(game_ID),
	FOREIGN KEY (store_ID) REFERENCES buying_games_onl.stores(store_ID)
);
DROP TABLE buying_games_onl.discounts;
