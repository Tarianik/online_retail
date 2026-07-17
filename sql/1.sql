CREATE OR REPLACE VIEW stg_valid AS
SELECT *
FROM stg
WHERE
	"Invoice" ~ '^(C?\d{6})$'
	AND "InvoiceDate" ~ '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$'
	AND "StockCode" !~* '^[a-z]+\d*'
	AND "Price" > 0