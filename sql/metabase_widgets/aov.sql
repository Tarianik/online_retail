SELECT r.month_name,
  EXTRACT(
    YEAR
    FROM invoice_date
  )::text AS year,
  SUM(oi.quantity * oi.unit_price) / NULLIF(
    COUNT(DISTINCT o.invoice_no) FILTER (
      WHERE NOT o.is_cancelled
    ),
    0
  ) AS aov
FROM orders o
  JOIN order_items oi ON oi.invoice_no = o.invoice_no
  JOIN ru_months r ON EXTRACT(
    MONTH
    FROM o.invoice_date
  ) = r.month_num
WHERE EXTRACT(
    YEAR
    FROM invoice_date
  )::text <> '2009'
GROUP BY 1,
  2,
  EXTRACT(
    MONTH
    FROM invoice_date
  )
ORDER BY EXTRACT(
    MONTH
    FROM invoice_date
  ),
  2;