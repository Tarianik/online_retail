SELECT date_trunc('month', invoice_date) AS MONTH,
  COUNT(*) FILTER (
    WHERE is_cancelled
  )::NUMERIC / COUNT(*) * 100 AS y
FROM orders
WHERE invoice_date < (
    SELECT date_trunc('month', MAX(invoice_date))
    FROM orders
  )
GROUP BY MONTH
ORDER BY MONTH