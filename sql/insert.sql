INSERT INTO customers (customer_id, country)
SELECT DISTINCT ON (customer_id) customer_id, country
FROM stg_valid
WHERE customer_id IS NOT NULL
ORDER BY customer_id, invoice_date DESC;

INSERT INTO orders (invoice_no, customer_id, invoice_date)
SELECT DISTINCT invoice_no, customer_id, invoice_date::timestamp
FROM stg_valid
WHERE invoice_no NOT IN (SELECT invoice_no FROM bad_invoices)
ORDER BY invoice_no;

INSERT INTO products (stock_code, description)
SELECT DISTINCT ON (stock_code) stock_code, description
FROM stg_valid
ORDER BY stock_code, invoice_date DESC;

INSERT INTO order_items (invoice_no, stock_code, quantity, unit_price)
SELECT invoice_no, stock_code, quantity, unit_price
FROM stg_valid
WHERE invoice_no NOT IN (SELECT invoice_no FROM bad_invoices);