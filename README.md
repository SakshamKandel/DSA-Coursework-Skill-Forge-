# SkillForge

SkillForge is a Java web application for managing an online course
catalog, student enrolments, quizzes and certificates. It is built as a
Java Dynamic Web Project using Jakarta EE (Servlets and JSP), follows
the Model-View-Controller pattern and stores its data in MySQL.

## Features

### Admin
- Create, edit and remove courses, categories and instructors.
- View the full list of students. Unlock locked accounts and remove
  students when needed.
- Create quizzes for each course and add multiple choice questions.
- View enrolments and read inquiries sent through the public Contact page.

### Student
- Register a new account or sign in with Google.
- Browse the course catalog, search by keyword and enrol in a course.
- Track progress on each enrolment and update it manually.
- Take the quiz for a course once progress reaches 100% and receive a
  certificate on a passing score.
- Update profile details, change password and upload a profile photo.

## Project structure

```
Skillforge/
  src/main/java/com/skillforge/
    config/        Database connection helper
    controllers/   Servlets that handle every request
    filters/       AccessFilter that enforces login and role
    model/         Plain Java classes that represent table rows
    service/       Business logic and JDBC code
    util/          Validation and AES encryption helpers
  src/main/webapp/
    css/           External stylesheets
    images/        Logo and illustrations
    WEB-INF/
      lib/         mysql-connector-j-9.6.0.jar
      pages/       All JSP views (admin/, student/, common/, error/)
      web.xml      Welcome file and custom error pages
  skillforge_db.sql  Full schema and seed data
```

## Requirements

- Java JDK 11 or newer
- Apache Tomcat 10.1
- MySQL 8.x (XAMPP works well)
- Eclipse IDE for Enterprise Java and Web Developers

## Setup

1. Create the database:
   - Start MySQL through the XAMPP control panel.
   - Open phpMyAdmin at `http://localhost/phpmyadmin`.
   - Import `skillforge_db.sql` from the project root. The script
     creates the `skillforge_db` database, all tables and the seed data.

2. Import the project into Eclipse:
   - File then Import then Existing Projects into Workspace.
   - Pick the SkillForge folder.

3. Run the project:
   - Make sure `WebContent/WEB-INF/lib/mysql-connector-j-9.6.0.jar`
     is present.
   - Right click the project then Run As then Run on Server.
   - Pick the Apache Tomcat 10.1 server. The app starts at
     `http://localhost:8082/SkillForge/`.

## Default accounts

Loaded by the SQL script for local testing.

| Role    | Email                  | Password     |
|---------|------------------------|--------------|
| Admin   | admin@skillforge.com   | Admin@2024   |
| Student | aarav@skillforge.com   | Student@123  |
| Student | sushma@skillforge.com  | Student@123  |
