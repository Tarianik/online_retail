CREATE OR REPLACE VIEW stg_valid AS
SELECT *
FROM stg
WHERE
	invoice_no ~ '^(C?\d{6})$'
	AND stock_code ~ '^\d+[a-zA-Z]*$'
	AND description IS NOT NULL
	AND unit_price > 0
