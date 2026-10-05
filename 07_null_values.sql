-- 7. Handling NULL values
-- Find orders where delivery date is not available
SELECT order_id, order_status, delivery_date
FROM orders
WHERE delivery_date IS NULL;

-- Replace NULL delivery dates with a readable label
SELECT order_id,
       order_status,
       COALESCE(delivery_date, 'Not Delivered Yet') AS delivery_status
FROM orders
ORDER BY order_id;
