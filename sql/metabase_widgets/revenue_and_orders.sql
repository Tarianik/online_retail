SELECT date_trunc('month', o.invoice_date) AS MONTH,
  sum(oi.unit_price * oi.quantity) AS "Выручка, £",
  COUNT(DISTINCT o.invoice_no) FILTER (
    WHERE NOT o.is_cancelled
  ) AS "Заказы"
FROM orders o
  JOIN order_items oi ON o.invoice_no = oi.invoice_no
WHERE invoice_date < '2011-12-01'
GROUP BY MONTH
ORDER BY MONTH