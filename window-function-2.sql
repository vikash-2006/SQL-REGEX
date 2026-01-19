-- =====================================================
-- WINDOW FUNCTIONS PRACTICE
-- =====================================================
-- Database used to practice:
--   • OVER()
--   • PARTITION BY
--   • ORDER BY
--   • ROW_NUMBER()
--   • RANK()
--   • DENSE_RANK()
-- =====================================================


-- ===============================
-- DATABASE & TABLE CREATION
-- ===============================

-- Create database if it does not exist
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
-- INSERT DATA INTO EMPLOYEES
-- ===============================

INSERT INTO employees (emp_id, full_name, department, city, salary, hire_date) VALUES
(101, 'Asha Nair',   'Sales',       'Mumbai',     65000,  '2022-04-10'),
(102, 'Rohan Mehta','Sales',       'Pune',       72000,  '2021-07-05'),
(103, 'Neha Singh', 'Sales',       'Delhi',      68000,  '2023-01-15'),
(104, 'Kabir Rao',  'Engineering', 'Bengaluru', 120000,  '2020-09-20'),
(105, 'Isha Verma', 'Engineering', 'Hyderabad', 110000,  '2021-11-12'),
(106, 'Vikram Das', 'Engineering', 'Bengaluru', 125000,  '2019-03-08'),
(107, 'Pooja Shah', 'HR',          'Mumbai',     60000,  '2020-02-01'),
(108, 'Arjun Iyer', 'HR',          'Chennai',    58000,  '2022-06-18');


-- ===============================
-- INSERT DATA INTO SALES
-- ===============================

INSERT INTO sales (sale_id, emp_id, sale_date, amount) VALUES
(1,  101, '2026-01-02', 12000.00),
(2,  101, '2026-01-05',  8000.00),
(3,  102, '2026-01-03', 15000.00),
(4,  102, '2026-01-09',  5000.00),
(5,  103, '2026-01-04',  7000.00),
(6,  103, '2026-01-10', 11000.00),
(7,  101, '2026-02-02', 14000.00),
(8,  102, '2026-02-03',  9000.00),
(9,  103, '2026-02-05', 13000.00),
(10, 101, '2026-02-08',  6000.00),
(11, 102, '2026-02-10', 16000.00),
(12, 103, '2026-02-12',  4000.00);


-- ===============================
-- BASIC SELECT
-- ===============================

SELECT *
FROM employees;


-- =====================================================
-- WINDOW FUNCTION: OVER()
-- =====================================================

-- 1. Total salary (entire table)
-- 2. Department-wise salary
-- 3. Department + city-wise salary

SELECT *,
       SUM(salary) OVER () AS total_salary,
       SUM(salary) OVER (PARTITION BY department) AS dept_salary,
       SUM(salary) OVER (PARTITION BY department, city) AS dept_city_salary
FROM employees;


-- =====================================================
-- RUNNING / CUMULATIVE SUM
-- =====================================================

-- 4. Running salary ordered by salary
SELECT *,
       SUM(salary) OVER (ORDER BY salary) AS running_salary
FROM employees;


-- 5. Running salary ordered by city
-- (Alphabetical order of city)
SELECT *,
       SUM(salary) OVER (ORDER BY city) AS running_salary_by_city
FROM employees;


-- 6. Department-wise running salary
SELECT *,
       SUM(salary) OVER (
           PARTITION BY department
           ORDER BY salary
       ) AS dept_running_salary
FROM employees;


-- =====================================================
-- ROW_NUMBER()
-- =====================================================
-- Assigns a unique number to each row


-- 7. Row number for entire table
SELECT *,
       ROW_NUMBER() OVER () AS row_no
FROM employees;


-- 8. Row number within each department
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY department) AS dept_row_no
FROM employees;


-- 9. Row number by department ordered by hire date
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY department
           ORDER BY hire_date
       ) AS dept_hire_rank
FROM employees;


-- =====================================================
-- RANK() and DENSE_RANK()
-- =====================================================
-- RANK      → Skips ranks if there are ties
-- DENSE_RANK→ Does NOT skip ranks


-- 10. Rank employees by salary (highest first)
SELECT *,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- 11. Rank employees by city
SELECT *,
       RANK() OVER (ORDER BY city) AS city_rank
FROM employees;


-- 12. Compare RANK and DENSE_RANK
SELECT *,
       RANK() OVER (ORDER BY city) AS city_rank,
       DENSE_RANK() OVER (
           PARTITION BY department
           ORDER BY salary
       ) AS dept_salary_dense_rank
FROM employees;

