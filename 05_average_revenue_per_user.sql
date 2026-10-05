-- 5. Average Revenue Per User (ARPU)
SELECT ROUND(
    SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0))
    / COUNT(DISTINCT o.customer_id),
    2
) AS average_revenue_per_user
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';
