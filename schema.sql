--  =========================================
-- Database Setup
-- =========================================
CREATE DATABASE alu_project;
USE alu_project;

-- =========================================
-- Member A: Students Table (CREATE TABLE)
-- =========================================
CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth   DATE,
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);

-- =========================================
-- Member A: Students Table (INSERT statements)
-- =========================================
INSERT INTO Students (first_name, last_name, email, date_of_birth, enrollment_date) VALUES
('Amara', 'Okafor', 'amara.okafor@alustudent.com', '2003-04-12', '2024-09-01'),
('Kwame', 'Mensah', 'kwame.mensah@alustudent.com', '2002-11-05', '2024-09-01'),
('Fatima', 'Diallo', 'fatima.diallo@alustudent.com', '2003-07-19', '2024-09-01'),
('Liam', 'Ndlovu', 'liam.ndlovu@alustudent.com', '2001-02-27', '2024-09-01'),
('Grace', 'Achieng', 'grace.achieng@alustudent.com', '2003-09-30', '2024-09-01');

-- =========================================
-- Member A: Students Table (UPDATE / DELETE / SELECT)
-- =========================================

-- Member A: Update
UPDATE Students
SET email = 'amara.okafor2@alustudent.com'
WHERE student_id = 1;

-- Member A: Delete
DELETE FROM Students
WHERE student_id = 4;

-- Member A: Select
SELECT first_name, last_name, enrollment_date
FROM Students
WHERE enrollment_date = '2024-09-01';
