CREATE DATABASE alu_project;
USE alu_project;
-- Member A: Students Table (CREATE TABLE)
CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth   DATE,
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);
INSERT INTO Students (first_name, last_name, email, date_of_birth, enrollment_date) VALUES
('Amara', 'Okafor', 'amara.okafor@alustudent.com', '2003-04-12', '2024-09-01'),
('Kwame', 'Mensah', 'kwame.mensah@alustudent.com', '2002-11-05', '2024-09-01'),
('Fatima', 'Diallo', 'fatima.diallo@alustudent.com', '2003-07-19', '2024-09-01'),
('Liam', 'Ndlovu', 'liam.ndlovu@alustudent.com', '2001-02-27', '2024-09-01'),
('Grace', 'Achieng', 'grace.achieng@alustudent.com', '2003-09-30', '2024-09-01');
UPDATE Students SET email = 'amara.okafor2@alustudent.com' WHERE student_id = 1;
DELETE FROM Students WHERE student_id = 4;
SELECT first_name, last_name, enrollment_date FROM Students WHERE enrollment_date = '2024-09-01';
-- Member B: Classroom Table (CREATE TABLE)
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    building VARCHAR(50),
    capacity INT
);
INSERT INTO Classroom (classroom_id, room_number, building, capacity) VALUES
(1, 'A101', 'Main Building', 30),
(2, 'A102', 'Main Building', 25),
(3, 'B201', 'Science Block', 40),
(4, 'B202', 'Science Block', 35),
(5, 'C301', 'Library Annex', 20);
UPDATE Classroom SET capacity = 45 WHERE classroom_id = 3;
DELETE FROM Classroom WHERE classroom_id = 5;
SELECT * FROM Classroom WHERE building = 'Main Building';
-- Member C: Faculty Table (CREATE TABLE)
CREATE TABLE Faculty (
  faculty_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  department VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(20),
  hire_date DATE,
  office VARCHAR(20)
);
INSERT INTO Faculty (first_name, last_name, department, email, phone, hire_date, office) VALUES
('Alice', 'Nguyen', 'Computer Science', 'alice.nguyen@uni.edu', '07884374850', '2015-08-15', 'B201'),
('Brian', 'Khan', 'Mathematics', 'brian.khan@uni.edu', '0787738459', '2016-09-01', 'C110'),
('Clara', 'Ochoa', 'Physics', 'clara.ochoa@uni.edu', '0723458295', '2018-01-10', 'D303'),
('Daniel', 'Smith', 'English', 'daniel.smith@uni.edu', '0734584956', '2012-07-23', 'A005'),
('Eva', 'Martinez', 'Biology', 'eva.martinez@uni.edu', '0784958495', '2019-02-12', 'E210');
UPDATE Faculty SET phone = '07812345678' WHERE faculty_id = 3;
DELETE FROM Faculty WHERE faculty_id = 5;
SELECT * FROM Faculty WHERE department = 'Mathematics';
-- Member D: Courses Table (CREATE TABLE)
CREATE TABLE Courses (
    course_id      INT PRIMARY KEY AUTO_INCREMENT,
    course_name    VARCHAR(100) NOT NULL,
    credits        INT NOT NULL,
    faculty_id     BIGINT UNSIGNED,
    classroom_id   INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);
INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES
('Introduction to Databases', 3, 1, 1),
('Web Development Fundamentals', 4, 2, 2),
('Data Structures and Algorithms', 4, 1, 3),
('Business Communication', 2, 3, 1),
('Leadership and Ethics', 3, 2, 2);
UPDATE Courses SET credits = 5 WHERE course_id = 1;
DELETE FROM Courses WHERE course_id = 5;
SELECT course_name, credits FROM Courses WHERE credits >= 4;


CREATE TABLE Extra_Curricular_Activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    faculty_advisor_id BIGINT UNSIGNED,
    FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
);

CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id) ON DELETE CASCADE
);

INSERT INTO Extra_Curricular_Activities (activity_name, category, faculty_advisor_id) VALUES
('Robotics Club', 'Technology', 1),
('Math Olympiad', 'Academic', 2),
('Debate Team', 'Arts', 4),
('Physics Society', 'Science', 3),
('Drama Club', 'Arts', 4);

INSERT INTO Student_Courses (student_id, course_id) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 1), (5, 2);

INSERT INTO Student_Activities (student_id, activity_id) VALUES
(1, 1), (2, 3), (3, 2), (5, 4), (1, 3);

UPDATE Extra_Curricular_Activities 
SET category = 'Engineering' 
WHERE activity_id = 1;

DELETE FROM Extra_Curricular_Activities 
WHERE activity_id = 5;

SELECT activity_name, faculty_advisor_id 
FROM Extra_Curricular_Activities 
WHERE category = 'Academic';



SELECT CONCAT(s.first_name, ' ', s.last_name, ' is enrolled in ', c.course_name, ', taught by ', f.first_name, ' ', f.last_name, ', in room ', cl.room_number, '.') AS enrollment_info
FROM Students s
JOIN Student_Courses sc ON s.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Faculty f ON c.faculty_id = f.faculty_id
JOIN Classroom cl ON c.classroom_id = cl.classroom_id;

SELECT CONCAT(s.first_name, ' ', s.last_name, ' participates in ', e.activity_name, ', advised by ', f.first_name, ' ', f.last_name, '.') AS activity_info
FROM Students s
JOIN Student_Activities sa ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities e ON sa.activity_id = e.activity_id
JOIN Faculty f ON e.faculty_advisor_id = f.faculty_id;

SELECT CONCAT('Professor ', f.last_name, ' from the ', f.department, ' department advises the ', e.activity_name, ' (', e.category, ').') AS advisor_info
FROM Faculty f
JOIN Extra_Curricular_Activities e ON f.faculty_id = e.faculty_advisor_id;

SELECT c.course_name, COUNT(sc.student_id) AS total_students
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_name;-- Normalization Discussion
-- Our tables are normalized so we're not repeating the same data over and over. Each table -- Students, Classroom, Faculty, Courses -- has its own primary key, and instead of copying details like a faculty member's name into every course they teach, we just reference them using a foreign key (faculty_id, classroom_id). That way, if a faculty member's info changes, we only update it in one place, not in every row that mentions them. The junction tables (Student_Courses and Student_Activities) follow the same idea -- instead of duplicating student, course, or activity info for every enrollment, they just store the IDs that connect them.
