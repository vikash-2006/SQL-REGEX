-- =====================================================
-- WINDOW FUNCTIONS PRACTICE (COMPLETE & CLEAN)
-- =====================================================
-- Window functions perform calculations across rows
-- without collapsing the result set like GROUP BY.
-- =====================================================


-- ===============================
-- DATABASE SETUP
-- ===============================

CREATE DATABASE IF NOT EXISTS window_fn_practice;
USE window_fn_practice;


-- ===============================
-- EMPLOYEES TABLE
-- ===============================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    hire_date DATE NOT NULL
);


-- ===============================
-- SALES TABLE
-- ===============================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


-- ===============================
-- INSERT EMPLOYEES DATA
-- ===============================

INSERT INTO employees (emp_id, full_name, department, city, salary, hire_date) VALUES
(101, 'Asha Nair', 'Sales', 'Mumbai', 65000, '2022-04-10'),
(102, 'Rohan Mehta', 'Sales', 'Pune', 72000, '2021-07-05'),
(103, 'Neha Singh', 'Sales', 'Delhi', 68000, '2023-01-15'),
(104, 'Kabir Rao', 'Engineering', 'Bengaluru', 120000, '2020-09-20'),
(105, 'Isha Verma', 'Engineering', 'Hyderabad', 110000, '2021-11-12'),
(106, 'Vikram Das', 'Engineering', 'Bengaluru', 125000, '2019-03-08'),
(107, 'Pooja Shah', 'HR', 'Mumbai', 60000, '2020-02-01'),
(108, 'Arjun Iyer', 'HR', 'Chennai', 58000, '2022-06-18');


-- ===============================
-- INSERT SALES DATA
-- ===============================

INSERT INTO sales (sale_id, emp_id, sale_date, amount) VALUES
(1, 101, '2026-01-02', 12000.00),
(2, 101, '2026-01-05', 8000.00),
(3, 102, '2026-01-03', 15000.00),
(4, 102, '2026-01-09', 5000.00),
(5, 103, '2026-01-04', 7000.00),
(6, 103, '2026-01-10', 11000.00),
(7, 101, '2026-02-02', 14000.00),
(8, 102, '2026-02-03', 9000.00),
(9, 103, '2026-02-05', 13000.00),
(10, 101, '2026-02-08', 6000.00),
(11, 102, '2026-02-10', 16000.00),
(12, 103, '2026-02-12', 4000.00);


-- =====================================================
-- BASIC VIEW
-- =====================================================

SELECT * FROM employees;
SELECT * FROM sales;


-- =====================================================
-- OVER() WITH PARTITION BY
-- =====================================================
-- Aggregate without GROUP BY

SELECT *,
       SUM(salary) OVER (PARTITION BY department) AS dept_total_salary,
       SUM(salary) OVER (PARTITION BY department, city) AS dept_city_salary
FROM employees;


-- =====================================================
-- RUNNING / CUMULATIVE SUM
-- =====================================================
-- ORDER BY inside OVER() gives running total

-- Overall running salary
SELECT *,
       SUM(salary) OVER (ORDER BY salary) AS running_salary
FROM employees;

-- Running salary within each department
SELECT *,
       SUM(salary) OVER (PARTITION BY department ORDER BY salary) AS dept_running_salary
FROM employees;


-- =====================================================
-- ROW_NUMBER()
-- =====================================================
-- Assigns unique number to each row

SELECT *,
       ROW_NUMBER() OVER () AS row_num
FROM employees;

SELECT *,
       ROW_NUMBER() OVER (PARTITION BY department) AS dept_row_num
FROM employees;

SELECT *,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date) AS hire_sequence
FROM employees;


-- =====================================================
-- RANK vs DENSE_RANK
-- =====================================================
-- RANK()       → skips next rank on tie
-- DENSE_RANK() → no skipping

SELECT *,
       RANK() OVER (ORDER BY city) AS city_rank,
       DENSE_RANK() OVER (ORDER BY city) AS city_dense_rank
FROM employees;

SELECT *,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary) AS dept_salary_rank
FROM employees;


-- =====================================================
-- COMPARISON: ROW_NUMBER vs RANK vs DENSE_RANK
-- =====================================================

SELECT *,
       ROW_NUMBER() OVER (ORDER BY city) AS row_no,
       RANK() OVER (ORDER BY city) AS rank_no,
       DENSE_RANK() OVER (ORDER BY city) AS dense_rank_no
FROM employees;


-- =====================================================
-- LEAD & LAG
-- =====================================================
-- LEAD → next row value
-- LAG  → previous row value
-- Used for comparison

SELECT *,
       LAG(salary, 1) OVER (ORDER BY salary) AS prev_salary,
       LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary
FROM employees;

SELECT *,
       LEAD(salary, 1) OVER (PARTITION BY department ORDER BY salary) AS next_dept_salary
FROM employees;


-- =====================================================
-- SALES ANALYSIS WITH WINDOW FUNCTIONS
-- =====================================================

-- Running total of sales (overall)
SELECT *,
       SUM(amount) OVER (ORDER BY sale_date) AS running_sales
FROM sales;

-- Running total of sales per employee
SELECT *,
       SUM(amount) OVER (PARTITION BY emp_id ORDER BY sale_date) AS emp_running_sales
FROM sales;

-- Total sales shown on every row
SELECT *,
       SUM(amount) OVER () AS total_sales
FROM sales;


-- =====================================================
-- ADVANCED ANALYTICS
-- =====================================================

-- Average salary per department on each row
SELECT *,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;

-- Top 2 salaries in each department
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
) AS tempdata
WHERE rn <= 2;

-- Salary difference from department average
SELECT *,
       salary - AVG(salary) OVER (PARTITION BY department) AS salary_diff
FROM employees;

-- Percent rank by salary (overall)
-- Formula: (rank - 1) / (total_rows - 1)
SELECT *,
       ROUND(PERCENT_RANK() OVER (ORDER BY salary), 2) AS percent_rank
FROM employees;
ss

