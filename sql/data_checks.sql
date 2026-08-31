/* quantity <= 0 */
SELECT *
FROM stg
WHERE quantity <= 0;

/* Некорректные stock_code */
SELECT
  stock_code, COUNT(*), SUM(COUNT(*)) OVER()
FROM stg
WHERE
  stock_code !~ '^\d+[a-zA-Z]*$'
GROUP BY stock_code
ORDER BY COUNT(*) DESC;

/* Нет description */
SELECT *
FROM stg
WHERE description IS NULL

/* quantity < 0 и invoice_no без префикса 'C' */
SELECT *
FROM stg
WHERE
	invoice_no NOT LIKE 'C%'
	AND quantity <= 0

/* Некорректные invoice_no */
SELECT *
FROM stg
WHERE "Invoice" !~ '^(C?\d{6})$';

/* Гостевые покупки */
SELECT *
FROM stg
WHERE customer_id IS NULL;