-- 2. GROUP BY + SUM + AVG
SELECT p.category,
       SUM(o.quantity) AS total_units_sold,
       ROUND(SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0)), 2) AS total_revenue,
       ROUND(AVG(o.quantity * p.price * (1 - o.discount_percent / 100.0)), 2) AS average_order_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;
