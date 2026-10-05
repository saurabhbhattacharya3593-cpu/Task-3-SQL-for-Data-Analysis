# Task 3: SQL for Data Analysis

## Internship
Data Analyst Internship — Elevate Labs

## Objective
Use SQL queries to extract and analyze data from a database.

## Dataset
Ecommerce SQL Database (sample ecommerce dataset created for this task).

## Tool
SQLite. SQLite is used because it is free and does not require a paid database server.

## Deliverables
- `Task_3_SQL_for_Data_Analysis.sql` — complete SQL submission
- Individual SQL files for each major task/query
- `ecommerce_database.db` — SQLite database
- `screenshots/` — screenshots of query outputs
- `README.md` — project explanation

## What is covered
1. SELECT, WHERE and ORDER BY
2. GROUP BY
3. Aggregate functions: SUM and AVG
4. INNER JOIN and LEFT JOIN
5. RIGHT JOIN equivalent for SQLite
6. Subqueries
7. Average Revenue Per User (ARPU)
8. Views for analysis
9. NULL handling with IS NULL and COALESCE
10. Query optimization with indexes and EXPLAIN QUERY PLAN

## Database Tables
### customers
Stores customer details such as customer ID, name, city and email.

### products
Stores product name, category and price.

### orders
Stores order details such as quantity, discount, dates, payment mode, order status, rating and delivery partner.

## How to Run
1. Open `Task_3_SQL_for_Data_Analysis.sql` in SQLiteStudio, DB Browser for SQLite, or another SQLite-compatible tool.
2. Run the script.
3. Review the query results.
4. The screenshots in `screenshots/` show example outputs generated from the same database.

## Interview Questions — Short Answers

### 1. What is the difference between WHERE and HAVING?
`WHERE` filters individual rows before grouping. `HAVING` filters groups after `GROUP BY`, and is commonly used with aggregate functions.

### 2. What are the different types of joins?
Common joins are INNER JOIN, LEFT JOIN, RIGHT JOIN and FULL OUTER JOIN. SQLite commonly uses INNER and LEFT JOIN; a RIGHT JOIN result can be achieved by reversing the table order and using LEFT JOIN.

### 3. How do you calculate average revenue per user in SQL?
Calculate total revenue and divide it by the number of distinct users/customers:
`SUM(revenue) / COUNT(DISTINCT customer_id)`.

### 4. What are subqueries?
A subquery is a query written inside another SQL query. It can provide a value or result set used by the outer query.

### 5. How do you optimize a SQL query?
Use appropriate indexes, select only required columns, filter early when practical, avoid unnecessary joins, and inspect the query plan using tools such as `EXPLAIN QUERY PLAN`.

### 6. What is a view in SQL?
A view is a saved SQL query that behaves like a virtual table. It is useful for reusable analysis and simplified reporting.

### 7. How would you handle NULL values in SQL?
Use `IS NULL` / `IS NOT NULL` to test for missing values and functions such as `COALESCE()` to replace NULL with a suitable value.

## Result
The project demonstrates how structured ecommerce data can be queried, joined, aggregated, filtered and analyzed using SQL.
