-- 4A. Customers whose delivered revenue is above the average customer revenue
SELECT customer_name, total_revenue
FROM (
    SELECT c.customer_id,
           c.customer_name,
           SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0)) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN products p ON o.product_id = p.product_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
) AS customer_sales
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM (
        SELECT SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0)) AS total_revenue
        FROM orders o
        JOIN products p ON o.product_id = p.product_id
        WHERE o.order_status = 'Delivered'
        GROUP BY o.customer_id
    ) AS avg_sales
)
ORDER BY total_revenue DESC;

-- 4B. Products priced above the average product price
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;
