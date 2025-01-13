-- PostgreSQL (Academic Records)


CREATE TABLE academic_programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    description TEXT,
    duration_years INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    program_id INT REFERENCES academic_programs(program_id),
    admission_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive', 'Graduated')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0),
    program_id INT REFERENCES academic_programs(program_id),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fragments

-- Active students fragment
CREATE TABLE active_students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    program_id INT,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Courses basic fragment
CREATE TABLE courses_basic (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    program_id INT
);