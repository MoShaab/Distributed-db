
-- MSSQL (Administrative)
CREATE TABLE departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    budget DECIMAL(12,2),
    location VARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE faculty (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    email VARCHAR(100) UNIQUE,
    position VARCHAR(50),
    hire_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active', 'On Leave', 'Retired')),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE financial_records (
    record_id INT IDENTITY(1,1) PRIMARY KEY,
    department_id INT REFERENCES departments(department_id),
    fiscal_year INT,
    quarter INT CHECK (quarter BETWEEN 1 AND 4),
    budget_allocated DECIMAL(12,2),
    budget_spent DECIMAL(12,2),
    created_at DATETIME DEFAULT GETDATE(),
    UNIQUE (department_id, fiscal_year, quarter)
);

--Fragments

-- Major departments fragment
CREATE TABLE major_departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    budget DECIMAL(12,2)
);

-- Active faculty fragment
CREATE TABLE active_faculty (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    status VARCHAR(20) DEFAULT 'Active'
);