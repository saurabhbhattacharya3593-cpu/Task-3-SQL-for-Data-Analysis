-- 1. SELECT + WHERE + ORDER BY
SELECT order_id, customer_id, quantity, payment_mode, order_status
FROM orders
WHERE order_status = 'Delivered'
ORDER BY order_date DESC;
