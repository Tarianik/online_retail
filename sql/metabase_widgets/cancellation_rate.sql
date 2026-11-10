SELECT 
    CONCAT(
        CASE EXTRACT(MONTH FROM invoice_date)
            WHEN 1 THEN 'Янв' WHEN 2 THEN 'Фев' WHEN 3 THEN 'Мар' WHEN 4 THEN 'Апр'
            WHEN 5 THEN 'Май' WHEN 6 THEN 'Июн' WHEN 7 THEN 'Июл' WHEN 8 THEN 'Авг'
            WHEN 9 THEN 'Сен' WHEN 10 THEN 'Окт' WHEN 11 THEN 'Ноя' WHEN 12 THEN 'Дек'
        END,
        ' ',
        TO_CHAR(invoice_date, 'YY')
    ) AS russian_date,   
    COUNT(*) FILTER (
    WHERE is_cancelled
  )::NUMERIC / COUNT(*) * 100 AS y
FROM orders
WHERE invoice_date < (
    SELECT date_trunc('month', MAX(invoice_date))
    FROM orders
  )
GROUP BY DATE_TRUNC('month', invoice_date), 1
ORDER BY DATE_TRUNC('month', invoice_date) ASC;
