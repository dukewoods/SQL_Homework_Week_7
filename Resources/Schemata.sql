-- -- Drop table if exists
DROP TABLE IF EXISTS card_holder;

-- -- Create new table
CREATE TABLE card_holder (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50)
);

-- Drop table if exists
DROP TABLE IF EXISTS credit_card;

-- Create new table
CREATE TABLE credit_card (
	card INT,
	cardholder_id PRIMARY KEY INT,
);

-- -- Create new table
ALTER TABLE credit_card
DROP CONSTRAINT credit_card_pkey;

-- Drop table if exists
DROP TABLE IF EXISTS merchant;

-- Create new table
CREATE TABLE merchant (
	id INT,
	name VARCHAR(50),
	id_merchant_category VARCHAR(50)
);

-- Drop table if exists
DROP TABLE IF EXISTS merchant_category;

-- Create new table
CREATE TABLE merchant_category (
	id SERIAL,
	name VARCHAR(50)
);

-- Drop table if exists
DROP TABLE IF EXISTS transaction;

-- Create new table
CREATE TABLE transaction(
	id SERIAL,
	date TIMESTAMP,
	amount FLOAT,
	card BIGINT,
	id_merchant INT
);

