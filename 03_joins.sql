-- 3A. INNER JOIN
SELECT o.order_id, c.customer_name, p.product_name, o.order_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id
ORDER BY o.order_id;

-- 3B. LEFT JOIN
SELECT c.customer_id, c.customer_name, o.order_id, o.order_status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

-- 3C. RIGHT JOIN equivalent for SQLite:
-- SQLite does not support RIGHT JOIN in older/common configurations.
-- The same result can be produced by reversing the table order with LEFT JOIN.
SELECT p.product_id, p.product_name, o.order_id, o.order_status
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
ORDER BY p.product_id, o.order_id;
