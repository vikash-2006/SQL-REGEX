-- ===============================
-- DATABASE SELECTION
-- ===============================

-- Use the WORLD database
USE world;

-- Show all tables in WORLD database
SHOW TABLES;


-- ===============================
-- SWITCH TO SAKILA DATABASE
-- ===============================

-- Use the SAKILA database
USE sakila;

-- Display all records from payment table
SELECT * FROM payment;


-- ===============================
-- NESTED QUERY (SUBQUERY)
-- ===============================
-- A nested query is a query inside another query


-- 1. Fetch payments where amount is equal to
--    the amount of payment_id = 5
-- (Single-row subquery)
SELECT *
FROM payment
WHERE amount = (
    SELECT amount
    FROM payment
    WHERE payment_id = 5
);


-- 2. Fetch payment_id and amount where amount
--    is NOT equal to the amount of payment_id = 23
SELECT payment_id, amount
FROM payment
WHERE amount != (
    SELECT amount
    FROM payment
    WHERE payment_id = 23
);


-- ===============================
-- DATE FUNCTION WITH SUBQUERY
-- ===============================

-- 3. Find the month of payment_date for payment_id = 6
SELECT MONTH(payment_date)
FROM payment
WHERE payment_id = 6;


-- 4. Display important columns from payment table
SELECT payment_id, amount, customer_id, payment_date
FROM payment;


-- 5. Fetch payments made in the SAME month
--    as the payment with payment_id = 6
SELECT payment_id, amount, customer_id, payment_date
FROM payment
WHERE MONTH(payment_date) = (
    SELECT MONTH(payment_date)
    FROM payment
    WHERE payment_id = 6
);


-- ===============================
-- STAFF BASED SUBQUERY
-- ===============================

-- 6. Find staff_id for payment_id = 7
SELECT staff_id
FROM payment
WHERE payment_id = 7;


-- 7. Fetch all payments handled by the SAME staff
--    who handled payment_id = 7
SELECT *
FROM payment
WHERE staff_id = (
    SELECT staff_id
    FROM payment
    WHERE payment_id = 7
);


-- ===============================
-- AGGREGATE FUNCTIONS WITH SUBQUERY
-- ===============================

-- 8. Find the maximum payment amount
SELECT MAX(amount)
FROM payment;


-- 9. Fetch all payments having the MAXIMUM amount
SELECT *
FROM payment
WHERE amount = (
    SELECT MAX(amount)
    FROM payment
);


-- ===============================
-- GROUP BY WITH SUBQUERY
-- ===============================

-- 10. Find amount for a specific rental_id
SELECT amount
FROM payment
WHERE rental_id = 1725;


-- 11. Count how many times that SAME amount occurs
--     (Grouped result)
SELECT amount, COUNT(amount) AS total_payments
FROM payment
WHERE amount = (
    SELECT amount
    FROM payment
    WHERE rental_id = 1725
)
GROUP BY amount;


-- ===============================
-- SINGLE ROW SUBQUERY EXAMPLE
-- ===============================
-- NOTE:
-- Single-row subquery returns ONLY ONE row


-- 12. Find month of payment_date where
--     customer_id = 1 AND payment_id = 3
SELECT MONTH(payment_date)
FROM payment
WHERE customer_id = 1
  AND payment_id = 3;


-- 13. Find total payment amount for months
--     GREATER than the month of payment_id = 3
--     for customer_id = 1
SELECT MONTH(payment_date), SUM(amount) AS total_amount
FROM payment
WHERE MONTH(payment_date) > (
    SELECT MONTH(payment_date)
    FROM payment
    WHERE customer_id = 1
      AND payment_id = 3
)
GROUP BY MONTH(payment_date);

    
    
    
-- multy row sub query
-- in any or all operator