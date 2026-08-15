SELECT o.country,
  sum(oi.unit_price * oi.quantity) AS "Выручка, £"
FROM orders o
  JOIN order_items oi ON oi.invoice_no = o.invoice_no
WHERE o.country <> 'United Kingdom'
GROUP BY o.country
ORDER BY "Выручка, £" DESC