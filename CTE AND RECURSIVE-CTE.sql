-- =====================================================
-- CTE (COMMON TABLE EXPRESSIONS)
-- =====================================================
-- CTE is a temporary result set
-- It exists only for the duration of the query
-- Improves readability and reusability
-- =====================================================


-- ===============================
-- SIMPLE CTE
-- ===============================

USE sakila;

-- Select actors between actor_id 5 and 80 using CTE
WITH vikas_cte AS (
    SELECT *
    FROM actor
    WHERE actor_id BETWEEN 5 AND 80
)
SELECT *
FROM vikas_cte;


-- =====================================================
-- CTE WITH FUNCTION (MONTH)
-- =====================================================

-- Count number of payments per month
WITH cte AS (
    SELECT *,
           MONTH(payment_date) AS payment_month
    FROM sakila.payment
)
SELECT payment_month, COUNT(*) AS total_payments
FROM cte
GROUP BY payment_month;


-- =====================================================
-- CTE WITH WINDOW FUNCTION
-- =====================================================

-- Find 2nd highest payment amount (overall)
WITH cte AS (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY amount DESC) AS ranking
    FROM sakila.payment
)
SELECT *
FROM cte
WHERE ranking = 2;


-- =====================================================
-- CTE WITH PARTITION BY
-- =====================================================

-- Find 2nd highest payment per customer
WITH cte AS (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY customer_id
               ORDER BY amount DESC
           ) AS ranking
    FROM sakila.payment
)
SELECT *
FROM cte
WHERE ranking = 2;


-- =====================================================
-- CORRELATED SUBQUERY EXAMPLE
-- =====================================================
-- Fetch employees whose salary is greater
-- than average salary of their department

SELECT e.emp_id,
       e.emp_name,
       e.department,
       e.salary
FROM employee AS e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);


-- =====================================================
-- UNION vs UNION ALL
-- =====================================================
-- UNION       → removes duplicate rows
-- UNION ALL   → keeps duplicate rows
-- Column count and data type must be same

-- UNION example (duplicates removed)
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 4
UNION
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 3 AND 5;

-- UNION ALL example (duplicates allowed)
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 4
UNION ALL
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 3 AND 5;


-- =====================================================
-- RECURSIVE CTE (BASIC EXAMPLE)
-- =====================================================
-- Generate numbers from 1 to 10

WITH RECURSIVE cte AS (
    -- Anchor member (starting point)
    SELECT 1 AS num

    UNION ALL

    -- Recursive member
    SELECT num + 1
    FROM cte
    WHERE num < 10
)
SELECT *
FROM cte;


-- =====================================================
-- EMPLOYEE HIERARCHY (MOST COMMON INTERVIEW QUESTION)
-- =====================================================

USE window_fn_practice;


-- ===============================
-- EMPLOYEE HIERARCHY TABLE
-- ===============================

CREATE TABLE employees2 (
    employeeid INT PRIMARY KEY,
    name VARCHAR(50),
    managerid INT
);


-- Insert hierarchy data
INSERT INTO employees2 (employeeid, name, managerid) VALUES
(1, 'Alice', NULL),   -- CEO
(2, 'Bob', 1),        -- Reports to Alice
(3, 'Charlie', 2),    -- Reports to Bob
(4, 'Diana', 2),      -- Reports to Bob
(5, 'Eve', 3);        -- Reports to Charlie


-- =====================================================
-- RECURSIVE CTE: HIERARCHY PATH
-- =====================================================

WITH RECURSIVE xyz AS (
    -- Anchor member (top-level manager)
    SELECT 
        employeeid,
        name,
        name AS hierarchy_path
    FROM employees2
    WHERE managerid IS NULL

    UNION ALL

    -- Recursive member
    SELECT 
        e.employeeid,
        e.name,
        CONCAT(xyz.hierarchy_path, ' -> ', e.name) AS hierarchy_path
    FROM employees2 AS e
    JOIN xyz
        ON e.managerid = xyz.employeeid
)
SELECT *
FROM xyz;


-- =====================================================
-- RECURSIVE CTE: HIERARCHY LEVEL
-- =====================================================

WITH RECURSIVE xyz AS (
    -- Anchor member
    SELECT 
        employeeid,
        name,
        1 AS level
    FROM employees2
    WHERE managerid IS NULL

    UNION ALL

    -- Recursive member
    SELECT 
        e.employeeid,
        e.name,
        xyz.level + 1 AS level
    FROM employees2 AS e
    JOIN xyz
        ON e.managerid = xyz.employeeid
)
SELECT *
FROM xyz;


-- CTE → improves readability

-- Recursive CTE → hierarchy, sequence, tree data

-- Anchor member → starting row

-- Recursive member → calls CTE itself

-- UNION → removes duplicates

-- UNION ALL → keeps duplicates

-- DENSE_RANK → best for Nth highest problems-- 



