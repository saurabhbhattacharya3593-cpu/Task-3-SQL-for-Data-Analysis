-- 9. Query optimization with indexes
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(order_status);
CREATE INDEX IF NOT EXISTS idx_orders_payment_status ON orders(payment_mode, order_status);

-- SQLite can show the query plan used for the filtered query.
EXPLAIN QUERY PLAN
SELECT order_id, customer_id, payment_mode, order_status
FROM orders
WHERE order_status = 'Delivered'
  AND payment_mode = 'UPI';
