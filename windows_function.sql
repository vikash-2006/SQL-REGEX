-- =====================================================
-- DDL vs DML COMMANDS
-- =====================================================
-- DROP     → Removes a table or database object permanently
-- ALTER    → Modifies the structure of an existing table
-- TRUNCATE → Removes all records from a table
--            • No WHERE condition allowed
--            • Cannot be rolled back
--            • DDL command
--
-- DELETE   → Removes records using a WHERE condition
--            • Can be rolled back
--            • DML command
--
-- OBJECT   → A structure used to store, manage,
--            or retrieve data (table, view, index, etc.)
-- =====================================================


-- ===============================
-- USE WORLD DATABASE
-- ===============================

USE world;


-- ===============================
-- BASIC SELECT QUERY
-- ===============================

-- Display country code, name, and population
SELECT code, name, population
FROM country;


-- ===============================
-- AGGREGATE FUNCTION
-- ===============================

-- Find total population of all countries
SELECT SUM(population) AS total_population
FROM country;


-- ===============================
-- SUBQUERY WITHOUT OVER()
-- ===============================
-- Total population will repeat for every row
-- but is calculated separately

SELECT code,
       name,
       continent,
       population,
       (SELECT SUM(population) FROM country) AS world_population
FROM country;


-- ===============================
-- WINDOW FUNCTION: OVER()
-- ===============================
-- OVER() allows aggregate values
-- without collapsing rows

SELECT code,
       name,
       continent,
       population,
       SUM(population) OVER () AS total_population,
       AVG(population) OVER () AS avg_population
FROM country;


-- ===============================
-- PARTITION BY
-- ===============================
-- PARTITION BY divides data into groups
-- Aggregate is applied per group

SELECT code,
       name,
       continent,
       population,
       SUM(population) OVER (PARTITION BY continent) AS continent_population,
       SUM(population) OVER () AS world_population
FROM country;


-- ===============================
-- RUNNING / CUMULATIVE SUM
-- ===============================
-- ORDER BY inside OVER() is used
-- to calculate running total

SELECT code,
       name,
       continent,
       population,
       SUM(population) OVER (ORDER BY population) AS running_population
FROM country;

  
                                                                                                        