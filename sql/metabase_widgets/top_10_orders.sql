SELECT p.stock_code,
  p.description,
  SUM(oi.quantity) FILTER (
    WHERE NOT o.is_cancelled
  ) AS "Валовые продажи",
  SUM(oi.quantity) AS "Чистые продажи"
FROM products p
  JOIN order_items oi ON oi.stock_code = p.stock_code
  JOIN orders o ON o.invoice_no = oi.invoice_no
GROUP BY p.stock_code,
  p.description
ORDER BY "Чистые продажи"  DESC
LIMIT 10;