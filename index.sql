-- =====================================================
-- ROLES / GROUPS (CONCEPT)
-- =====================================================
-- A ROLE (or GROUP) is a collection of privileges.
-- Steps:
-- 1. Create a role (group)
-- 2. Grant privileges to the role
-- 3. Add users to the role
-- 4. Check privileges
--
-- (Note: MySQL supports roles from version 8.0+)
-- =====================================================


-- =====================================================
-- INDEXES IN SQL
-- =====================================================
-- INDEX is used to improve the speed of data retrieval.
-- It works like a book index.
--
-- Types:
-- 1. Clustered Index
-- 2. Non-Clustered Index
-- 3. Composite (Multi-column) Index
-- 4. Partial Index (Prefix index)
-- =====================================================


-- ===============================
-- USE DATABASE
-- ===============================

USE sakila;


-- ===============================
-- DROP TABLE IF EXISTS
-- ===============================

DROP TABLE IF EXISTS tes100;


-- =====================================================
-- CLUSTERED INDEX
-- =====================================================
-- In MySQL, PRIMARY KEY creates a clustered index.
-- Table data is physically sorted by primary key.

-- Create table
CREATE TABLE tes100 AS
SELECT actor_id, first_name
FROM actor
WHERE actor_id BETWEEN 1 AND 10;

SELECT * FROM tes100;

-- View structure
DESC tes100;


-- Add PRIMARY KEY (Clustered Index)
ALTER TABLE tes100
ADD PRIMARY KEY (actor_id);


-- Query using primary key (fast lookup)
EXPLAIN
SELECT *
FROM tes100
WHERE actor_id = 5;

-- Query without index (table scan)
EXPLAIN
SELECT *
FROM tes100
WHERE first_name = 'NICK';


-- =====================================================
-- NON-CLUSTERED INDEX
-- =====================================================
-- Index created separately from table data.

DROP TABLE IF EXISTS tes100;

CREATE TABLE tes100 AS
SELECT actor_id, first_name
FROM actor
WHERE actor_id BETWEEN 1 AND 10;

-- Insert extra rows
INSERT INTO tes100 VALUES
(14, 'abc'),
(13, 'def');


-- Create non-clustered index
CREATE INDEX indx1
ON tes100 (actor_id);

-- View indexes
SHOW INDEX FROM tes100;

-- Drop index
DROP INDEX indx1 ON tes100;


-- Insert more data
INSERT INTO tes100 VALUES
(12, 'abc'),
(15, 'def');


-- Query using indexed column
EXPLAIN
SELECT *
FROM tes100
WHERE actor_id = 5;

-- Query on non-indexed column
EXPLAIN
SELECT *
FROM tes100
WHERE first_name = 'NICK';

-- Duplicate values → more rows scanned
EXPLAIN
SELECT *
FROM tes100
WHERE actor_id = 12;

-- Unique-like value → fewer rows scanned
EXPLAIN
SELECT *
FROM tes100
WHERE actor_id = 14;


-- =====================================================
-- COMPOSITE (MULTI-COLUMN) INDEX
-- =====================================================
-- Index created on more than one column.
-- Order of columns is very important.

CREATE INDEX indx_composite
ON tes100 (actor_id, first_name);

SHOW INDEX FROM tes100;

-- Drop composite index
DROP INDEX indx_composite ON tes100;


SELECT * FROM tes100;

-- Won’t use index properly (actor_id missing)
EXPLAIN
SELECT *
FROM tes100
WHERE first_name = 'abc';

-- Uses composite index
EXPLAIN
SELECT *
FROM tes100
WHERE actor_id > 5
  AND first_name = 'abc';


-- Insert more data
INSERT INTO tes100 VALUES
(16, 'johpy'),
(17, 'johmp'),
(18, 'johnty'),
(19, 'johny'),
(20, 'johry');

SELECT * FROM tes100;


-- =====================================================
-- PARTIAL INDEX (PREFIX INDEX)
-- =====================================================
-- Used for character columns.
-- Index only first N characters.

SHOW INDEX FROM tes100;

-- Create prefix index (first 3 characters)
CREATE INDEX indx1_3_chr
ON tes100 (first_name(3));


-- Equality check (less effective)
EXPLAIN
SELECT *
FROM tes100
WHERE first_name = 'JOH%';

-- Pattern matching (uses prefix index)
EXPLAIN
SELECT *
FROM tes100
WHERE first_name LIKE 'JOH%';


EXPLAIN
SELECT *
FROM tes100
WHERE first_name = 'abc%';

EXPLAIN
SELECT *
FROM tes100
WHERE first_name LIKE 'abc%';




-- ASSIGNMENT
-- read indexex



