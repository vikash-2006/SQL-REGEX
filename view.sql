-- =====================================================
-- VIEWS IN SQL
-- =====================================================
-- A VIEW is a virtual table.
-- It does NOT store data physically.
-- It stores a SELECT query.
--
-- Whenever a view is queried,
-- the stored query is executed on base tables.
--
-- In simple words:
-- VIEW = Saved SELECT statement
-- =====================================================


-- ===============================
-- WHY USE VIEWS?
-- ===============================
-- 1. Security      → Hide sensitive columns
-- 2. Simplicity    → Avoid rewriting complex queries
-- 3. Consistency   → Same logic used everywhere


-- =====================================================
-- SIMPLE VIEW EXAMPLE
-- =====================================================

USE regex1;

-- Create base table from sakila.actor
CREATE TABLE newactor AS
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 3;

SELECT * FROM newactor;


-- Create a simple view
-- Uses a single table
-- No aggregation
-- Updatable
CREATE VIEW actor_v AS
SELECT *,
       SUBSTR(first_name, 2) AS modified_name
FROM newactor;

SELECT * FROM actor_v;


-- Insert into base table
INSERT INTO newactor VALUES (4, 'Riya');

-- Changes reflect automatically in the view
SELECT * FROM newactor;
SELECT * FROM actor_v;


-- =====================================================
-- SIMPLE VIEW WITH FILTER
-- =====================================================
-- DML changes on base table
-- will be visible in the view

CREATE VIEW actor_v2 AS
SELECT *
FROM newactor
WHERE actor_id IN (1, 2);

SELECT * FROM actor_v2;

-- Insert new data
INSERT INTO newactor VALUES (5, 'Sakshi');

-- View still follows its WHERE condition
SELECT * FROM actor_v2;


-- =====================================================
-- TYPES OF VIEWS
-- =====================================================
-- 1. SIMPLE VIEW
--    • Single table
--    • No GROUP BY / JOIN
--    • Updatable
--
-- 2. COMPLEX VIEW
--    • Multiple tables OR aggregation
--    • Uses COUNT, SUM, JOIN, GROUP BY, DISTINCT
--    • NOT updatable


-- =====================================================
-- COMPLEX VIEW EXAMPLE
-- =====================================================

CREATE TABLE new_payments AS
SELECT payment_id, amount
FROM sakila.payment
WHERE payment_id BETWEEN 1 AND 7;

SELECT * FROM new_payments;


-- Create complex view (aggregation used)
CREATE VIEW payment_v AS
SELECT COUNT(*) AS total_payments
FROM new_payments;

SELECT * FROM payment_v;

-- ERROR: Cannot insert into complex view
-- INSERT INTO payment_v VALUES (10);


-- =====================================================
-- DATABASE OBJECTS
-- =====================================================
-- A database object is any logical structure
-- created inside a database.
--
-- Examples:
-- • Table
-- • View
-- • Index
-- • Procedure
-- • Trigger
-- • User
-- =====================================================


-- =====================================================
-- USERS & PRIVILEGES (DDL + DCL)
-- =====================================================

-- Create a user
CREATE USER regex IDENTIFIED BY 'regex';

-- View all users
SELECT * FROM mysql.user;


-- Create a new database
CREATE DATABASE tushardb;


-- Create tables in another database
CREATE TABLE tushardb.actor1 AS
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 5;

CREATE TABLE tushardb.actor2 AS
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 3 AND 7;


-- Check user permissions
SHOW GRANTS FOR regex;


-- Grant SELECT permission on one table
GRANT SELECT ON tushardb.actor2 TO regex;

-- Grant SELECT permission on entire database
GRANT SELECT ON tushardb.* TO regex;

-- Grant ALL privileges on a table
GRANT ALL PRIVILEGES ON tushardb.actor1 TO regex;


-- =====================================================
-- MATERIALIZED vs NON-MATERIALIZED VIEW
-- =====================================================
-- NOTE:
-- MySQL supports ONLY Non-Materialized Views
-- Materialized Views are available in Oracle, PostgreSQL
-- =====================================================

-- NON-MATERIALIZED VIEW (Normal View)
-- • Stores only query
-- • Data fetched at runtime
-- • Always up-to-date
-- • Slower for complex queries

-- Example:
-- CREATE VIEW sales_view AS
-- SELECT product_id, SUM(amount) AS total_sales
-- FROM sales
-- GROUP BY product_id;


-- MATERIALIZED VIEW (Conceptual)
-- • Stores actual data physically
-- • Faster query performance
-- • Data can become outdated
-- • Needs manual refresh

