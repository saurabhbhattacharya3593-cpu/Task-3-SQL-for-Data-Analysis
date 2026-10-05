-- ============================================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- Dataset: Ecommerce_SQL_Database
-- Tool: SQLite
-- ============================================================

-- This file creates the ecommerce database, inserts sample data,
-- creates indexes, and runs the analysis queries required by Task 3.

PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS customer_revenue;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    city TEXT,
    email TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT,
    price REAL NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    discount_percent REAL DEFAULT 0,
    order_date TEXT,
    delivery_date TEXT,
    payment_mode TEXT,
    order_status TEXT,
    rating INTEGER,
    delivery_partner TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Aman Sharma', 'Bhopal', 'aman@example.com'),
(2, 'Riya Verma', 'Indore', 'riya@example.com'),
(3, 'Rahul Singh', 'Jabalpur', 'rahul@example.com'),
(4, 'Neha Patel', 'Bhopal', 'neha@example.com'),
(5, 'Karan Mehta', 'Gwalior', 'karan@example.com'),
(6, 'Priya Joshi', 'Indore', 'priya@example.com'),
(7, 'Arjun Gupta', 'Ujjain', 'arjun@example.com'),
(8, 'Sneha Rao', 'Bhopal', 'sneha@example.com');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 65000),
(102, 'Smartphone', 'Electronics', 30000),
(103, 'Headphones', 'Accessories', 2500),
(104, 'Keyboard', 'Accessories', 1800),
(105, 'Office Chair', 'Furniture', 8500),
(106, 'Monitor', 'Electronics', 15000),
(107, 'Backpack', 'Bags', 2200),
(108, 'Mouse', 'Accessories', 900);

INSERT INTO orders VALUES
(1001, 1, 101, 1, 5, '2026-09-01', '2026-09-04', 'UPI', 'Delivered', 5, 'Delhivery'),
(1002, 2, 102, 2, 10, '2026-09-02', '2026-09-05', 'Card', 'Delivered', 4, 'BlueDart'),
(1003, 3, 103, 3, 0, '2026-09-03', '2026-09-06', 'UPI', 'Delivered', 5, 'Ecom Express'),
(1004, 4, 105, 1, 8, '2026-09-04', NULL, 'Cash on Delivery', 'Shipped', NULL, 'Delhivery'),
(1005, 5, 106, 2, 5, '2026-09-05', '2026-09-08', 'UPI', 'Delivered', 4, 'BlueDart'),
(1006, 6, 104, 2, 0, '2026-09-06', NULL, 'Card', 'Cancelled', NULL, NULL),
(1007, 7, 107, 1, 10, '2026-09-07', '2026-09-10', 'UPI', 'Delivered', 3, 'Ecom Express'),
(1008, 1, 108, 2, 0, '2026-09-08', '2026-09-10', 'UPI', 'Delivered', 5, 'Delhivery'),
(1009, 2, 106, 1, 5, '2026-09-09', NULL, 'Card', 'Shipped', NULL, 'BlueDart'),
(1010, 3, 102, 1, 7, '2026-09-10', '2026-09-13', 'UPI', 'Delivered', 4, 'Ecom Express'),
(1011, 4, 103, 4, 0, '2026-09-11', '2026-09-14', 'Cash on Delivery', 'Delivered', 5, 'Delhivery'),
(1012, 5, 105, 1, 12, '2026-09-12', NULL, 'UPI', 'Processing', NULL, NULL),
(1013, 6, 101, 1, 3, '2026-09-13', '2026-09-17', 'Card', 'Delivered', 4, 'BlueDart'),
(1014, 7, 104, 3, 5, '2026-09-14', '2026-09-16', 'UPI', 'Delivered', 5, 'Ecom Express'),
(1015, 8, 108, 3, 0, '2026-09-15', '2026-09-17', 'UPI', 'Delivered', 4, 'Delhivery'),
(1016, 8, 107, 1, 5, '2026-09-16', NULL, 'Card', 'Shipped', NULL, 'BlueDart'),
(1017, 5, 102, 1, 0, '2026-09-17', '2026-09-20', 'UPI', 'Delivered', 5, 'Ecom Express'),
(1018, 2, 103, 2, 10, '2026-09-18', '2026-09-21', 'UPI', 'Delivered', 4, 'Delhivery');

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_product_id ON orders(product_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_payment_status ON orders(payment_mode, order_status);

-- ============================================================
-- 01_basic_select_where_order_by.sql
-- ============================================================
-- 1. SELECT + WHERE + ORDER BY
SELECT order_id, customer_id, quantity, payment_mode, order_status
FROM orders
WHERE order_status = 'Delivered'
ORDER BY order_date DESC;

-- ============================================================
-- 02_group_by_aggregate.sql
-- ============================================================
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

-- ============================================================
-- 03_joins.sql
-- ============================================================
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

-- ============================================================
-- 04_subqueries.sql
-- ============================================================
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

-- ============================================================
-- 05_average_revenue_per_user.sql
-- ============================================================
-- 5. Average Revenue Per User (ARPU)
SELECT ROUND(
    SUM(o.quantity * p.price * (1 - o.discount_percent / 100.0))
    / COUNT(DISTINCT o.customer_id),
    2
) AS average_revenue_per_user
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'Delivered';

-- ============================================================
-- 06_view_for_analysis.sql
-- ============================================================
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

-- ============================================================
-- 07_null_values.sql
-- ============================================================
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

-- ============================================================
-- 08_where_vs_having.sql
-- ============================================================
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

-- ============================================================
-- 09_query_optimization_indexes.sql
-- ============================================================
-- 9. Query optimization with indexes
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(order_status);
CREATE INDEX IF NOT EXISTS idx_orders_payment_status ON orders(payment_mode, order_status);

-- SQLite can show the query plan used for the filtered query.
EXPLAIN QUERY PLAN
SELECT order_id, customer_id, payment_mode, order_status
FROM orders
WHERE order_status = 'Delivered'
  AND payment_mode = 'UPI';
