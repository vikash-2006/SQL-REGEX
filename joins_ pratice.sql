-- =====================================================
-- SQL JOINS, AGGREGATES & GROUP BY : PRACTICE FILE
-- Author: Vikash Kumawat
-- Purpose: Well-arranged queries with comments & definitions
-- =====================================================

-- ================================
-- 1. DATABASE CREATION
-- ================================
-- CREATE DATABASE is used to create a new database
CREATE DATABASE REGEX;

-- USE selects the database to work with
USE REGEX;

-- ================================
-- 2. TABLE CREATION
-- ================================
-- Customers table stores customer information
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50)
);

-- Orders table stores order-related information
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
amount DECIMAL(10,2)
);

-- ================================
-- 3. INSERT DATA INTO TABLES
-- ================================
-- Insert records into customers table
INSERT INTO customers VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago'),
(4, 'David', 'Houston'),
(5, 'Eva', 'Phoenix'),
(6, 'Frank', 'Philadelphia'),
(7, 'Grace', 'San Antonio'),
(8, 'Henry', 'San Diego'),
(9, 'Ivy', 'Dallas'),
(10, 'Jack', 'San Jose');

-- Insert records into orders table
-- Note: customer_id 11 and 12 do not exist in customers table
INSERT INTO orders VALUES
(101, 1, '2024-01-05', 250.00),
(102, 2, '2024-01-06', 150.00),
(103, 3, '2024-01-07', 300.00),
(104, 1, '2024-01-10', 120.00),
(105, 5, '2024-01-12', 450.00),
(106, 6, '2024-01-15', 200.00),
(107, 2, '2024-01-18', 175.00),
(108, 8, '2024-01-20', 500.00),
(109, 11, '2024-01-22', 90.00),
(110, 12, '2024-01-25', 60.00);

-- ================================
-- 4. DISPLAY DATABASE & TABLE DATA
-- ================================
SHOW DATABASES;
SHOW TABLES;

-- View all records
SELECT * FROM customers;
SELECT * FROM orders;

-- ================================
-- 5. INNER JOIN
-- ================================
-- Definition:
-- INNER JOIN returns only the matching records from both tables
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- ================================
-- 6. INNER JOIN USING WHERE (OLD STYLE)
-- ================================
-- Works same as INNER JOIN but less readable
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c, orders o
WHERE c.customer_id = o.customer_id;

-- ================================
-- 7. LEFT OUTER JOIN
-- ================================
-- Definition:
-- LEFT JOIN returns all records from left table
-- and matching records from right table
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- ================================
-- 8. RIGHT OUTER JOIN
-- ================================
-- Definition:
-- RIGHT JOIN returns all records from right table
-- and matching records from left table
SELECT c.customer_id, c.customer_name, o.order_id, o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- ================================
-- 9. NATURAL JOIN
-- ================================
-- Definition:
-- NATURAL JOIN automatically joins tables using
-- columns with the same name
SELECT customer_id, customer_name, order_id, amount
FROM customers
NATURAL JOIN orders;

-- ================================
-- 10. ALTER TABLE
-- ================================
-- ALTER TABLE is used to modify table structure
ALTER TABLE customers RENAME COLUMN customer_id TO cid;

-- ================================
-- 11. INNER JOIN AFTER COLUMN RENAME
-- ================================
SELECT c.cid, c.customer_name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o
ON c.cid = o.customer_id;

-- ================================
-- 12. CROSS JOIN (CARTESIAN JOIN)
-- ================================
-- Definition:
-- CROSS JOIN combines every row of first table
-- with every row of second table
SELECT *
FROM customers
CROSS JOIN orders;

-- ================================
-- 13. AGGREGATE FUNCTIONS
-- ================================
-- SUM() returns total of numeric column
SELECT SUM(amount) AS total_amount
FROM orders;

-- ================================
-- 14. GROUP BY
-- ================================
-- GROUP BY groups rows with same values
SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.cid = o.customer_id
GROUP BY c.customer_name;

-- ================================
-- 15. HAVING CLAUSE
-- ================================
-- HAVING is used to filter grouped data
SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
ON c.cid = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.amount) > 300;

-- ================================
-- 16. SAKILA DATABASE PRACTICE
-- ================================
USE sakila;

-- Count number of films acted by each actor
SELECT a.actor_id, a.first_name, COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name;

-- ================================
-- END OF FILE
-- ================================

-- what is normalisation in sql
-- what is 1NF 2NF 3NF
-- (partial dependency =>> non key attribute)

-- what are otter joins self joins


