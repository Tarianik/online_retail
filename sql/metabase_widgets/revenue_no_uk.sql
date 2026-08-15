SELECT CASE
    WHEN o.country = 'United Kingdom' THEN 'United Kingdom'
    ELSE 'Other'
  END AS _country,
  sum(oi.unit_price * oi.quantity) AS "Выручка, £"
FROM orders o
  JOIN order_items oi ON oi.invoice_no = o.invoice_no
GROUP BY _country
ORDER BY "Выручка, £" DESC