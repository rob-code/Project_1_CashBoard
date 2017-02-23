DROP TABLE transactions;
DROP TABLE users;
DROP TABLE categories;

CREATE TABLE categories(
id SERIAL8 primary key,
category_name VARCHAR(255),
);

CREATE TABLE users(
id SERIAL8 primary key,
name VARCHAR(255),
monthly_budget NUMERIC(6,2),
);

CREATE TABLE transactions(
id SERIAL8 primary key,
merchant_name VARCHAR(255),
amount NUMERIC(6,2),
category_id references categories(id) ON DELETE CASCADE
user_id references users(id) ON DELETE CASCADE
);


