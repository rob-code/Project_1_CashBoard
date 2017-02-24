DROP TABLE budgets;
DROP TABLE targets;
DROP TABLE transactions;
DROP TABLE users;
DROP TABLE categories;

CREATE TABLE categories(
id SERIAL8 primary key,
category_name VARCHAR(255)
);

CREATE TABLE users(
id SERIAL8 primary key,
first_name VARCHAR(255),
second_name VARCHAR(255)
);

CREATE TABLE transactions(
id SERIAL8 primary key,
merchant_name VARCHAR(255),
amount NUMERIC(6,2),
category_id INT8 references categories(id) ON DELETE CASCADE,
user_id INT8 references users(id) ON DELETE CASCADE
);

CREATE TABLE targets(
id SERIAL8 primary key,
target_amount NUMERIC(6,2),
category_id INT8 references categories(id) ON DELETE CASCADE,
user_id INT8 references users(id) ON DELETE CASCADE
);

CREATE TABLE budgets(
id SERIAL8 primary key,
total_budget NUMERIC(6,2),
user_id INT8 references users(id) ON DELETE CASCADE
);