-- =====================================================
-- CORRELATED SUBQUERY EXAMPLE
-- =====================================================
-- A correlated subquery is executed repeatedly.
-- It depends on values from the OUTER query.
-- The subquery cannot run independently.
-- =====================================================


-- ===============================
-- DATABASE SETUP
-- ===============================

-- Create a new database
CREATE DATABASE regexcorr;

-- Use the database
USE regexcorr;


-- ===============================
-- TABLE CREATION
-- ===============================

-- Create employee table
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    salary INT,
    department_name VARCHAR(50)
);


-- ===============================
-- INSERT DATA
-- ===============================

-- Insert employee records
INSERT INTO employee (eid, ename, salary, department_name) VALUES
(1,  'Emp1',  30000, 'HR'),
(2,  'Emp2',  32000, 'HR'),
(3,  'Emp3',  34000, 'HR'),
(4,  'Emp4',  36000, 'HR'),
(5,  'Emp5',  38000, 'HR'),

(6,  'Emp6',  50000, 'IT'),
(7,  'Emp7',  52000, 'IT'),
(8,  'Emp8',  54000, 'IT'),
(9,  'Emp9',  56000, 'IT'),
(10, 'Emp10', 58000, 'IT'),

(11, 'Emp11', 60000, 'Finance'),
(12, 'Emp12', 62000, 'Finance'),
(13, 'Emp13', 64000, 'Finance'),
(14, 'Emp14', 66000, 'Finance'),
(15, 'Emp15', 68000, 'Finance'),

(16, 'Emp16', 40000, 'Sales'),
(17, 'Emp17', 42000, 'Sales'),
(18, 'Emp18', 44000, 'Sales'),
(19, 'Emp19', 46000, 'Sales'),
(20, 'Emp20', 48000, 'Sales');


-- ===============================
-- AGGREGATE QUERY
-- ===============================

-- 1. Find average salary of each department
SELECT department_name, AVG(salary) AS avg_salary
FROM employee
GROUP BY department_name;


-- ===============================
-- CORRELATED SUBQUERY
-- ===============================
-- Subquery uses outer query reference (e.department_name)


-- 2. Fetch employees whose salary is GREATER than
--    the average salary of their own department
SELECT eid, ename, department_name, salary
FROM employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
    WHERE department_name = e.department_name
);


-- ===============================
-- SAME LOGIC USING SELF JOIN
-- ===============================

-- 3. Using self join to compare employee salary
--    with department average
SELECT e.eid, e.ename, e.department_name, e.salary
FROM employee e
JOIN employee emp
    ON e.department_name = emp.department_name
GROUP BY e.eid, e.ename, e.department_name, e.salary
HAVING AVG(emp.salary) < e.salary;


-- ===============================
-- CORRELATED SUBQUERY WITH MIN
-- ===============================

-- 4. Fetch employees having MINIMUM salary
--    in their respective departments
SELECT eid, ename, department_name, salary
FROM employee e
WHERE salary = (
    SELECT MIN(salary)
    FROM employee
    WHERE department_name = e.department_name
);


-- ===============================
-- USING ALL KEYWORD
-- ===============================

-- 5. Same result using ALL
--    (salary less than or equal to all salaries in department)
SELECT eid, ename, department_name, salary
FROM employee e
WHERE salary <= ALL (
    SELECT salary
    FROM employee
    WHERE department_name = e.department_name
);


-- ===============================
-- SELF JOIN WITH MIN (CORRECTED)
-- ===============================

-- 6. Fetch employees whose salary is the MINIMUM
--    in their department using self join
SELECT e.eid, e.ename, e.department_name, e.salary
FROM employee e
JOIN employee emp
    ON e.department_name = emp.department_name
GROUP BY e.eid, e.ename, e.department_name, e.salary
HAVING e.salary = MIN(emp.salary);
