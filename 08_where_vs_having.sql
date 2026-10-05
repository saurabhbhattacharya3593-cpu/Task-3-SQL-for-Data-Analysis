-- WHERE filters rows before GROUP BY.
SELECT payment_mode, COUNT(*) AS order_count
FROM orders
WHERE order_status = 'Delivered'
GROUP BY payment_mode;

-- HAVING filters groups after GROUP BY.
SELECT payment_mode,
       COUNT(*) AS order_count
FROM orders
GROUP BY payment_mode
HAVING COUNT(*) >= 5;
