-- SkillForge database schema for the Online Course Enrollment System.
-- Target MySQL 8.x. Run this file through XAMPP phpMyAdmin or the mysql CLI.
-- The schema is normalised to 3NF; categories and instructors are kept in
-- their own tables instead of being stored directly on the courses table.

DROP DATABASE IF EXISTS skillforge_db;
CREATE DATABASE skillforge_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE skillforge_db;

-- Table 1: users
-- Stores both admin and student accounts. The failed_attempts and
-- is_locked columns implement the account lockout policy.
CREATE TABLE users (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(100)  NOT NULL,
    email           VARCHAR(150)  NOT NULL UNIQUE,
    password        VARCHAR(255)  NOT NULL,
    phone           VARCHAR(15)   NOT NULL UNIQUE,
    role            ENUM('admin','student') NOT NULL DEFAULT 'student',
    failed_attempts INT           NOT NULL DEFAULT 0,
    is_locked       TINYINT       NOT NULL DEFAULT 0,
    reset_token     VARCHAR(100)  DEFAULT NULL,
    profile_photo   LONGBLOB      DEFAULT NULL,
    joined_at       TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Table 2: categories
-- Stored separately so course rows do not repeat the category name.
CREATE TABLE categories (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(80)   NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table 3: instructors
-- Stored separately for the same normalisation reason as categories.
CREATE TABLE instructors (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    full_name      VARCHAR(100)  NOT NULL,
    specialty      VARCHAR(100)  DEFAULT NULL
) ENGINE=InnoDB;

-- Table 4: courses
-- References categories and instructors by foreign key.
CREATE TABLE courses (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    title           VARCHAR(150)  NOT NULL,
    category_id     INT           NOT NULL,
    instructor_id   INT           NOT NULL,
    duration_weeks  INT           NOT NULL DEFAULT 4,
    description     TEXT,
    active          TINYINT       NOT NULL DEFAULT 1,
    created_at      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id)   REFERENCES categories(id)   ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(id)   ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 5: enrollments
-- Links a student to a course and tracks the learning progress.
CREATE TABLE enrollments (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT           NOT NULL,
    course_id      INT           NOT NULL,
    enrolled_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    progress       INT           NOT NULL DEFAULT 0 CHECK (progress BETWEEN 0 AND 100),
    status         ENUM('active','completed','dropped') NOT NULL DEFAULT 'active',
    UNIQUE KEY uq_student_course (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 6: quizzes
-- A quiz belongs to exactly one course.
CREATE TABLE quizzes (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    course_id      INT           NOT NULL,
    title          VARCHAR(255)  NOT NULL,
    description    TEXT,
    passing_score  INT           DEFAULT 70,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 7: quiz_questions
-- Each row is one multiple choice question that belongs to a quiz.
CREATE TABLE quiz_questions (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id        INT           NOT NULL,
    question_text  TEXT          NOT NULL,
    option_a       VARCHAR(255)  NOT NULL,
    option_b       VARCHAR(255)  NOT NULL,
    option_c       VARCHAR(255)  NOT NULL,
    option_d       VARCHAR(255)  NOT NULL,
    correct_option CHAR(1)       NOT NULL, -- one of A, B, C or D
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 8: quiz_attempts
-- Records every quiz attempt by a student and the resulting score.
CREATE TABLE quiz_attempts (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT           NOT NULL,
    quiz_id        INT           NOT NULL,
    score          INT           NOT NULL,
    passed         TINYINT(1)    DEFAULT 0,
    attempted_at   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id)    REFERENCES quizzes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 9: certifications
-- A certificate is issued when a student passes the quiz for a course.
CREATE TABLE certifications (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT           NOT NULL,
    course_id      INT           NOT NULL,
    attempt_id     INT           NOT NULL,
    cert_code      VARCHAR(50)   UNIQUE NOT NULL,
    issued_at      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Table 10: contact_messages
-- Stores inquiries submitted through the public Contact page so the admin
-- can read them on the admin Messages page.
CREATE TABLE contact_messages (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    full_name      VARCHAR(100)  NOT NULL,
    email          VARCHAR(150)  NOT NULL,
    subject        VARCHAR(200)  NOT NULL,
    message        TEXT          NOT NULL,
    sent_at        TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    handled        TINYINT       NOT NULL DEFAULT 0
) ENGINE=InnoDB;


-- Seed data for development and demos.
--
-- The passwords below are encrypted with AES/ECB/PKCS5Padding using the
-- key "SkillForge@2024!". The plain values for testing are:
--   admin@skillforge.com  / Admin@2024
--   aarav@skillforge.com  / Student@123
--   sushma@skillforge.com / Student@123

INSERT INTO users (full_name, email, password, phone, role) VALUES
('Admin User',    'admin@skillforge.com',  'ei0KBl/vjaQwtSKyyWetNg==',  '9800000001', 'admin'),
('Aarav Sharma',  'aarav@skillforge.com',  'tJILQnKTUAuVe8YKTE8M2g==',  '9800000002', 'student'),
('Sushma Thapa',  'sushma@skillforge.com', 'tJILQnKTUAuVe8YKTE8M2g==',  '9800000003', 'student');

-- Categories
INSERT INTO categories (name) VALUES
('Programming'),
('Data Science'),
('Design'),
('Cloud'),
('Security');

-- Instructors
INSERT INTO instructors (full_name, specialty) VALUES
('Prof. Ramesh Khatri', 'Java and Enterprise Apps'),
('Dr. Anjali Mehta',    'Data Analytics and ML'),
('Sneha Gurung',        'UI/UX and Prototyping'),
('Bikash Adhikari',     'AWS and Cloud Infrastructure'),
('Priya Singh',         'Network Security and Ethics');

-- Courses
INSERT INTO courses (title, category_id, instructor_id, duration_weeks, description) VALUES
('Java Full-Stack Development',  1, 1, 12, 'Master Java SE, Jakarta EE, JDBC, Servlets, JSP and build production-ready web applications from scratch.'),
('Data Science with Python',     2, 2,  8, 'Learn NumPy, Pandas, Matplotlib, Scikit-learn and real-world data analysis techniques with hands-on projects.'),
('UI/UX Design Fundamentals',    3, 3,  6, 'Explore user research, wireframing, prototyping and usability testing using Figma and Adobe XD.'),
('Cloud Computing on AWS',       4, 4, 10, 'Dive into EC2, S3, Lambda, RDS, VPC and prepare for the AWS Solutions Architect Associate exam.'),
('Cybersecurity Essentials',     5, 5,  8, 'Understand network security, ethical hacking, vulnerability assessment and incident response protocols.');

-- A few sample enrollments so the dashboards have data to show
INSERT INTO enrollments (student_id, course_id, progress, status) VALUES
(2, 1, 45,  'active'),
(2, 3, 100, 'completed'),
(3, 2, 20,  'active');

-- Sample quizzes and questions for each course
INSERT INTO quizzes (course_id, title, description, passing_score) VALUES
(1, 'Java Fundamentals Quiz', 'Test your knowledge on core Java concepts like loops, classes and inheritance.', 80),
(2, 'Python Data Structures', 'Quiz covering Lists, Dictionaries and NumPy basics.', 70),
(3, 'Figma and Design Principles', 'Focus on colour theory and prototyping steps.', 75),
(4, 'AWS Core Services', 'IAM, EC2 and S3 knowledge check.', 80),
(5, 'Network Security Basics', 'Assess your understanding of firewalls and encryption.', 70);

INSERT INTO quiz_questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
-- Java questions
(1, 'Which of these is NOT a primitive type in Java?', 'int', 'boolean', 'String', 'char', 'C'),
(1, 'What is the default value of an uninitialized int variable?', '0', 'null', '1', 'undefined', 'A'),
(1, 'Which keyword is used to inherit a class in Java?', 'implements', 'extends', 'inherits', 'import', 'B'),
-- Python questions
(2, 'Which data structure is mutable?', 'Tuple', 'String', 'List', 'None of the above', 'C'),
-- Figma questions
(3, 'What is the primary tool for creating components in Figma?', 'Ctrl+K', 'Ctrl+Alt+K', 'Alt+C', 'Ctrl+Shift+K', 'B'),
-- AWS questions
(4, 'Which AWS service provides scalable object storage?', 'EC2', 'RDS', 'S3', 'Lambda', 'C'),
-- Cybersecurity questions
(5, 'What does TLS stand for?', 'Total Level Security', 'Transport Layer Security', 'Time Limit System', 'Trust Layer Solution', 'B');
