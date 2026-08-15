/* Некорректные invoice_no */
SELECT *
FROM stg
WHERE "Invoice" !~ '^(C?\d{6})$';

/* Некорректные stock_code */
SELECT
  stock_code, COUNT(*), SUM(COUNT(*)) OVER()
FROM stg
WHERE
  stock_code !~ '^\d+[a-zA-Z]*$'
GROUP BY stock_code
ORDER BY COUNT(*) DESC;

