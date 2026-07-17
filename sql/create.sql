CREATE TABLE customers (
	customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	country VARCHAR(60)
);

CREATE TABLE products (
	stock_code VARCHAR(20) PRIMARY KEY,
	description VARCHAR(255)
);

CREATE TABLE orders (
	invoice_no VARCHAR(20) PRIMARY KEY,
	invoice_date TIMESTAMP,
	customer_id BIGINT REFERENCES customers(customer_id),
	is_cancelled BOOLEAN GENERATED ALWAYS AS (LEFT(invoice_no, 1) = 'C') STORED
);

CREATE TABLE order_items (
	order_item_id BIGINT GENERATED ALWAYS AS IDENTITY,
	invoice_no VARCHAR(10) REFERENCES orders(invoice_no),
	stock_code VARCHAR(10) REFERENCES products(stock_code),
	quantity INT,
	unit_price NUMERIC(10,2)
);