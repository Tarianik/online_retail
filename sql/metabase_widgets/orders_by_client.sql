WITH first_purchase AS (
  SELECT customer_id,
    MIN(invoice_date) AS first_date
  FROM orders
  WHERE customer_id IS NOT NULL
    AND NOT is_cancelled
    AND invoice_date < '2011-12-01'
  GROUP BY customer_id
)
SELECT DATE_TRUNC('month', o.invoice_date) AS MONTH,
  CASE
    WHEN o.customer_id IS NULL THEN 'Гости'
    WHEN o.invoice_date = fp.first_date THEN 'Новые пользователи'
    ELSE 'Вернувшиеся пользователи'
  END AS status,
  COUNT(*) AS orders
FROM orders o
  LEFT JOIN first_purchase fp ON fp.customer_id = o.customer_id
WHERE NOT o.is_cancelled
  AND invoice_date < '2011-12-01'
GROUP BY MONTH,
  status
ORDER BY MONTH,
  status;