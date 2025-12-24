-- =========================================================
-- SELF JOIN IN SQL
-- =========================================================
-- Definition:
-- A SELF JOIN is a type of JOIN where a table is joined with
-- itself. It is mainly used when a table has a hierarchical
-- relationship, such as employee–manager data.
-- =========================================================


-- ---------------------------------------------------------
-- 1. Select the database
-- ---------------------------------------------------------
USE regex;


-- ---------------------------------------------------------
-- 2. Create EMPLOYEE table
-- ---------------------------------------------------------
-- emp_id      : Unique ID for each employee (Primary Key)
-- emp_name    : Name of the employee
-- job_title   : Job role of the employee
-- manager_id  : emp_id of the manager (Self-referencing FK)
-- salary      : Salary of the employee
-- ---------------------------------------------------------
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
);


-- ---------------------------------------------------------
-- 3. Insert data into EMPLOYEE table
-- ---------------------------------------------------------
INSERT INTO employee (emp_id, emp_name, job_title, manager_id, salary) VALUES
(1,  'Alice',   'CEO',                NULL, 120000),

(2,  'Bob',     'CTO',                1,    95000),
(3,  'Carol',   'CFO',                1,    90000),
(4,  'David',   'HR Manager',         1,    85000),

(5,  'Eve',     'Tech Lead',           2,    75000),
(6,  'Frank',   'Senior Developer',    2,    72000),
(7,  'Grace',   'Senior Developer',    2,    71000),

(8,  'Heidi',   'Developer',           5,    60000),
(9,  'Ivan',    'Developer',           5,    58000),
(10, 'Judy',    'Developer',           6,    59000),

(11, 'Mallory', 'Accountant',          3,    65000),
(12, 'Niaj',    'Financial Analyst',   3,    62000),

(13, 'Olivia',  'HR Executive',        4,    55000),
(14, 'Peggy',   'HR Executive',        4,    54000),

(15, 'Sybil',   'Intern',              8,    35000);


-- ---------------------------------------------------------
-- 4. Display all records from EMPLOYEE table
-- ---------------------------------------------------------
-- Purpose:
-- View complete employee data
-- ---------------------------------------------------------
SELECT * 
FROM employee;


-- ---------------------------------------------------------
-- 5. View employee details (Employee perspective)
-- ---------------------------------------------------------
-- Purpose:
-- Display employee id, name, and manager id
-- ---------------------------------------------------------
SELECT 
    emp.emp_id,
    emp.emp_name,
    emp.manager_id
FROM employee AS emp;


-- ---------------------------------------------------------
-- 6. View manager details (Manager perspective)
-- ---------------------------------------------------------
-- Purpose:
-- Same table viewed as managers using alias
-- ---------------------------------------------------------
SELECT 
    mgr.emp_id,
    mgr.emp_name,
    mgr.manager_id
FROM employee AS mgr;


-- ---------------------------------------------------------
-- 7. SELF JOIN: Employee with their Manager
-- ---------------------------------------------------------
-- Definition:
-- This query joins the employee table with itself to show
-- which employee works under which manager.
--
-- emp : Represents employee
-- mgr : Represents manager
-- ---------------------------------------------------------
SELECT 
    emp.emp_id        AS employee_id,
    emp.emp_name      AS employee_name,
    emp.salary        AS employee_salary,
    mgr.emp_id        AS manager_id,
    mgr.emp_name      AS manager_name,
    mgr.salary        AS manager_salary
FROM employee AS emp
JOIN employee AS mgr
ON emp.manager_id = mgr.emp_id;





