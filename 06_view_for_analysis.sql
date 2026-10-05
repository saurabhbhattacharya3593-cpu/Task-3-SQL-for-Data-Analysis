-- 6. Create a view for reusable revenue analysis
DROP VIEW IF EXISTS customer_revenue;

CREATE VIEW customer_revenue AS
SELECT c.customer_id,
       c.customer_name,
       c.city,
       ROUND(SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0)), 2) AS total_revenue,
       COUNT(o.order_id) AS delivered_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city;

SELECT * FROM customer_revenue
ORDER BY total_revenue DESC;
