CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    country VARCHAR(50) NOT NULL  
);

CREATE TABLE products (
    stock_code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    invoice_no VARCHAR(10) PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    invoice_date TIMESTAMP NOT NULL,
    is_cancelled BOOLEAN GENERATED ALWAYS AS (LEFT(invoice_no, 1) = 'C') STORED,
    country VARCHAR(60) NOT NULL
);

CREATE TABLE order_items (
    order_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_no VARCHAR(10) NOT NULL REFERENCES orders(invoice_no),
    stock_code VARCHAR(20) NOT NULL REFERENCES products(stock_code),
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL
);