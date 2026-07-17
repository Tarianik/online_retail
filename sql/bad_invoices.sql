CREATE OR REPLACE VIEW bad_invoices AS
SELECT invoice_no
FROM stg_valid
GROUP BY invoice_no
HAVING COUNT(DISTINCT customer_id) > 1
    OR COUNT(DISTINCT invoice_date) > 1;