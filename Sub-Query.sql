-- ===============================
-- USE SAKILA DATABASE
-- ===============================

USE sakila;


-- ===============================
-- VIEW PAYMENT TABLE
-- ===============================

-- Display all records from the payment table
SELECT *
FROM payment;


-- ===============================
-- SUBQUERY WITH IN
-- ===============================
-- IN is used when the subquery returns MULTIPLE values


-- 1. Fetch payments where amount matches
--    amount of payment_id = 2 or 3
SELECT *
FROM payment
WHERE amount IN (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- ===============================
-- SUBQUERY WITH NOT IN
-- ===============================
-- NOT IN excludes matching values


-- 2. Fetch payments where amount does NOT match
--    amount of payment_id = 2 or 3
SELECT *
FROM payment
WHERE amount NOT IN (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- ===============================
-- SUBQUERY WITH ANY
-- ===============================
-- ANY compares a value with ANY one value
-- returned by the subquery


-- 3. Same as IN when used with '='
SELECT *
FROM payment
WHERE amount = ANY (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- 4. Fetch payments where amount is GREATER than
--    AT LEAST ONE of the amounts (payment_id = 2 or 3)
SELECT *
FROM payment
WHERE amount > ANY (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- 5. Fetch payments where amount is GREATER THAN OR EQUAL TO
--    AT LEAST ONE of the subquery values
SELECT *
FROM payment
WHERE amount >= ANY (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- 6. Fetch payments where amount is LESS than
--    AT LEAST ONE of the subquery values
SELECT *
FROM payment
WHERE amount < ANY (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- ===============================
-- SUBQUERY WITH ALL
-- ===============================
-- ALL compares a value with EVERY value
-- returned by the subquery


-- 7. Fetch payments where amount is GREATER than ALL
--    subquery values (sabse bada)
SELECT *
FROM payment
WHERE amount > ALL (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- 8. Fetch payments where amount is LESS than ALL
--    subquery values (sabse chota)
SELECT *
FROM payment
WHERE amount < ALL (
    SELECT amount
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- ===============================
-- DATE FUNCTION WITH SUBQUERY
-- ===============================

-- 9. Fetch payments where payment month matches
--    month of payment_id = 2 or 3
SELECT *
FROM payment
WHERE MONTH(payment_date) IN (
    SELECT MONTH(payment_date)
    FROM payment
    WHERE payment_id = 3
       OR payment_id = 2
);


-- ===============================
-- ALL WITH DIFFERENT PAYMENT IDS
-- ===============================

-- 10. Fetch payments where amount is GREATER than ALL
--     amounts of payment_id = 2 or 8
SELECT *
FROM payment
WHERE amount > ALL (
    SELECT amount
    FROM payment
    WHERE payment_id = 2
       OR payment_id = 8
);


