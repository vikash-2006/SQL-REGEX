-- Select the Sakila database
USE sakila;

-- Show all tables in Sakila
SHOW TABLES;

-- Switch to the World database
USE world;

-- CITY table: id is primary key, countrycode is a foreign key
SELECT * FROM city;

-- Get structure of the city table
DESCRIBE city;

-- COUNTRY table: code is primary key
DESCRIBE country;

---------------------------------------------------
-- 1. Display basic city details
---------------------------------------------------
SELECT 
    cy.id, 
    cy.name, 
    cy.countrycode
FROM city AS cy;

---------------------------------------------------
-- 2. Display basic country details
---------------------------------------------------
SELECT 
    cnt.name, 
    cnt.continent, 
    cnt.code
FROM country AS cnt;

---------------------------------------------------
-- 3. Join CITY and COUNTRY using foreign key
--    Show city id, city name, country code, 
--    country name, and continent
---------------------------------------------------
SELECT 
    cy.id, 
    cy.name, 
    cy.countrycode,
    cnt.code, 
    cnt.name AS country_name, 
    cnt.continent
FROM city AS cy
JOIN country AS cnt
ON cy.countrycode = cnt.code;

---------------------------------------------------
-- 4. Join CITY and COUNTRY
--    Show city name, population, country name, 
--    and type of government
---------------------------------------------------
SELECT 
    cy.name AS city_name, 
    cy.population AS city_population,
    cnt.name AS country_name, 
    cnt.governmentform
FROM city AS cy
JOIN country AS cnt
ON cy.countrycode = cnt.code;

---------------------------------------------------
-- 5. Join COUNTRYLANGUAGE and COUNTRY
--    Shows language %, country name, and population
---------------------------------------------------
SELECT 
    cl.language,
    cl.percentage,
    cnt.name AS country_name,
    cnt.population
FROM countrylanguage AS cl
JOIN country AS cnt
ON cl.countrycode = cnt.code;
