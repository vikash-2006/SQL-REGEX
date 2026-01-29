-- =====================================================
-- TCL : TRANSACTION CONTROL LANGUAGE
-- =====================================================
-- TCL is used to manage transactions in SQL.
--
-- Transaction:
-- A transaction is a set of logical SQL statements
-- whose result is NOT permanent until COMMIT is used.
--
-- Important Points:
-- 1. Transactions work mainly with DML commands.
-- 2. COMMIT makes changes permanent.
-- 3. ROLLBACK cancels changes.
-- 4. SAVEPOINT allows partial rollback.
-- 5. DDL or DCL automatically closes a transaction.
-- =====================================================


-- ===============================
-- USE DATABASE
-- ===============================

USE regex1;


-- ===============================
-- TABLE SETUP
-- ===============================

-- Drop table if already exists
DROP TABLE IF EXISTS actor_cp;

-- Create table using data from sakila.actor
CREATE TABLE actor_cp AS
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 5;

-- Insert a new record
INSERT INTO actor_cp VALUES (6, 'abhishek');

-- View data
SELECT * FROM actor_cp;


-- =====================================================
-- AUTOCOMMIT
-- =====================================================
-- AUTOCOMMIT is enabled by default.
-- If AUTOCOMMIT = 1 → every DML is committed automatically.
-- If AUTOCOMMIT = 0 → manual COMMIT or ROLLBACK needed.

-- Check autocommit status
SELECT @@autocommit;

-- Disable autocommit
SET @@autocommit = 0;

-- Enable autocommit
SET @@autocommit = 1;


-- ===============================
-- DML WITH AUTOCOMMIT
-- ===============================

INSERT INTO actor_cp VALUES (7, 'abhi');
INSERT INTO actor_cp VALUES (8, 'ashish');

-- Disable safe updates to allow update without WHERE
SET sql_safe_updates = 0;

-- Update all rows
UPDATE actor_cp
SET actor_id = 1000;

SELECT * FROM actor_cp;

-- Make changes permanent
COMMIT;

-- Rollback has no effect after commit
ROLLBACK;


-- =====================================================
-- START TRANSACTION
-- =====================================================
-- START TRANSACTION stops auto-commit even if it is ON.
-- Changes remain in pending state until COMMIT or ROLLBACK.

START TRANSACTION;

INSERT INTO actor_cp VALUES (11, 'amazon');

SELECT * FROM actor_cp;

-- To make changes permanent:
-- 1. Use COMMIT
-- 2. OR run any DDL command

-- DDL closes transaction automatically
CREATE TABLE xyz (
    id INT
);


-- =====================================================
-- ROLLBACK EXAMPLE
-- =====================================================

START TRANSACTION;

INSERT INTO actor_cp VALUES (12, 'abc');
INSERT INTO actor_cp VALUES (13, 'cdf');

DELETE
FROM actor_cp
WHERE actor_id IN (1, 2);

-- Undo all changes made after START TRANSACTION
ROLLBACK;

SELECT * FROM actor_cp;


-- =====================================================
-- SAVEPOINT
-- =====================================================
-- SAVEPOINT allows partial rollback.

START TRANSACTION;

INSERT INTO actor_cp VALUES (15, 'abcasdf');
INSERT INTO actor_cp VALUES (16, 'cdf654');

-- Create savepoint
SAVEPOINT in_actor_cp;

DELETE
FROM actor_cp
WHERE actor_id IN (5, 1);

-- Rollback only till savepoint
ROLLBACK TO in_actor_cp;

SELECT * FROM actor_cp;
