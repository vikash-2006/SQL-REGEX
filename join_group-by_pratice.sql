-- =========================================================
-- 📌 25 DEC PRACTICE: JOINS + GROUP BY
-- =========================================================
-- This file includes:
-- ✦ JOIN
-- ✦ LEFT JOIN with NULL filter
-- ✦ GROUP BY
-- ✦ HAVING
-- ✦ Aggregate functions COUNT & SUM
-- =========================================================


-- ---------------------------------------------------------
-- 1️⃣ USE DATABASE
-- ---------------------------------------------------------
USE regex;


-- ---------------------------------------------------------
-- 2️⃣ CREATE TABLE: STUDENTS
-- ---------------------------------------------------------
-- student_id     : Unique ID for each student (Primary Key)
-- student_name   : Name of the student
-- major          : Department name
-- ---------------------------------------------------------
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    major VARCHAR(50)
);


-- ---------------------------------------------------------
-- 3️⃣ INSERT SAMPLE DATA INTO STUDENTS
-- ---------------------------------------------------------
INSERT INTO students (student_id, student_name, major) VALUES
(1, 'Aarav', 'Computer Science'),
(2, 'Bhavya', 'Mathematics'),
(3, 'Chetan', 'Physics'),
(4, 'Diya', 'Computer Science'),
(5, 'Esha', 'Mathematics'),
(6, 'Farhan', 'Physics'),
(7, 'Gauri', 'Computer Science'),
(8, 'Harsh', 'Mathematics'),
(9, 'Isha', 'Physics'),
(10, 'Jay', 'Computer Science'),
(11, 'Kiran', 'Mathematics'),
(12, 'Leena', 'Physics'),
(13, 'Manav', 'Computer Science'),
(14, 'Neha', 'Mathematics'),
(15, 'Om', 'Physics'),
(16, 'Pooja', 'Computer Science'),
(17, 'Qadir', 'Mathematics'),
(18, 'Riya', 'Physics'),
(19, 'Sahil', 'Computer Science'),
(20, 'Tina', 'Mathematics');


-- ---------------------------------------------------------
-- 4️⃣ CREATE TABLE: ENROLLMENTS
-- ---------------------------------------------------------
-- enrollment_id  : Course enrollment number
-- student_id     : Matching with students table (FK)
-- course_name    : Name of the course taken
-- credits        : Course credit score
-- ---------------------------------------------------------
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    credits INT
);


-- ---------------------------------------------------------
-- 5️⃣ INSERT SAMPLE DATA INTO ENROLLMENTS
-- ---------------------------------------------------------
INSERT INTO enrollments (enrollment_id, student_id, course_name, credits) VALUES
(101, 1, 'Data Structures', 4),
(102, 1, 'Algorithms', 4),
(103, 2, 'Linear Algebra', 3),
(104, 3, 'Quantum Mechanics', 4),
(105, 4, 'Operating Systems', 4),
(106, 5, 'Statistics', 3),
(107, 6, 'Electromagnetism', 4),
(108, 7, 'Databases', 4),
(109, 8, 'Probability', 3),
(110, 9, 'Thermodynamics', 4),
(111, 10, 'Computer Networks', 4),
(112, 11, 'Calculus II', 3),
(113, 12, 'Optics', 4),
(114, 13, 'Machine Learning', 4),
(115, 14, 'Discrete Math', 3),
(116, 15, 'Nuclear Physics', 4),
(117, 16, 'Software Engineering', 4),
(118, 17, 'Numerical Methods', 3),
(119, 18, 'Solid State Physics', 4),
(120, 1, 'Artificial Intelligence', 4);


-- ---------------------------------------------------------
-- 6️⃣ SHOW TABLES AND DATA
-- ---------------------------------------------------------
SHOW TABLES;
SELECT * FROM students;
SELECT * FROM enrollments;


-- ---------------------------------------------------------
-- 7️⃣ INNER JOIN: Student with Course Details
-- ---------------------------------------------------------
-- Definition:
-- RETURN only records where matching data exists in both tables
-- ---------------------------------------------------------
SELECT 
    s.student_id,
    s.student_name,
    e.enrollment_id,
    e.course_name
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id;


-- ---------------------------------------------------------
-- 8️⃣ LEFT JOIN with NULL: Students NOT enrolled in any course
-- ---------------------------------------------------------
-- Definition:
-- LEFT JOIN returns all students, even if they have NO enrollment.
-- Using WHERE e.enrollment_id IS NULL filters non-enrolled.
-- ---------------------------------------------------------
SELECT 
    s.student_id,
    s.student_name
FROM students AS s
LEFT JOIN enrollments AS e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- ---------------------------------------------------------
-- 9️⃣ GROUP BY + COUNT: Total courses per student
-- ---------------------------------------------------------
-- Definition:
-- COUNT() returns total number of rows grouped by student_id.
-- ---------------------------------------------------------
SELECT 
    s.student_id,
    s.student_name,
    COUNT(e.enrollment_id) AS total_courses
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY s.student_id;


-- ---------------------------------------------------------
-- 🔟 GROUP BY + HAVING: Students with more than 2 courses
-- ---------------------------------------------------------
-- Definition:
-- HAVING is used instead of WHERE for conditions on aggregates.
-- ---------------------------------------------------------
SELECT 
    s.student_id,
    s.student_name,
    COUNT(e.enrollment_id) AS total_courses
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.enrollment_id) > 2;


-- ---------------------------------------------------------
-- 1️⃣1️⃣ COUNT by Major (Department Strength)
-- ---------------------------------------------------------
SELECT 
    major,
    COUNT(student_id) AS total_students
FROM students
GROUP BY major;


-- ---------------------------------------------------------
-- 1️⃣2️⃣ SUM of Credits by Major
-- ---------------------------------------------------------
-- Definition:
-- SUM() adds up values grouped by major using JOIN
-- ---------------------------------------------------------
SELECT 
    s.major,
    SUM(e.credits) AS total_credits
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY s.major;


-- ---------------------------------------------------------
-- 1️⃣3️⃣ CHARACTER LENGTH + GROUP BY + ORDER + LIMIT
-- ---------------------------------------------------------
-- Purpose:
-- Find which name-length group has the most enrollments
-- ---------------------------------------------------------
SELECT 
    CHAR_LENGTH(s.student_name) AS name_length,
    COUNT(s.student_id) AS total_students,
    COUNT(e.enrollment_id) AS total_enrollments
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY CHAR_LENGTH(s.student_name)
ORDER BY COUNT(e.enrollment_id) DESC
LIMIT 1;
