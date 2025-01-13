
-- MSSQL (Administrative)
CREATE TABLE IF NOT EXISTS departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    budget DECIMAL(12,2),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE IF NOT EXISTS faculty (
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

CREATE TABLE IF NOT EXISTS financial_records (
    record_id INT IDENTITY(1,1) PRIMARY KEY,
    department_id INT REFERENCES departments(department_id),
    budget_spent DECIMAL(12,2),
    fiscal_year INT, 
    created_at DATETIME DEFAULT GETDATE(),
    UNIQUE (department_id, fiscal_year)
);

--Financial_records Fragments

-- current_financial fragment
CREATE TABLE current_financial_records (
    record_id INT PRIMARY KEY,
    department_id INT,
    budget_spent DECIMAL(10,2),
    fiscal_year INT

);

-- previous_financial fragment
CREATE TABLE previous_financial_records (
    record_id INT PRIMARY KEY,
    department_id INT,
    budget_spent DECIMAL(10,2),
    fiscal_year INT

);

-- historical_financial fragment


CREATE TABLE historical_financial_records (
    record_id INT PRIMARY KEY,
    department_id INT,
    budget_spent DECIMAL(10,2),
    fiscal_year INT
    
);
-- Major departments fragment
CREATE TABLE major_departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    budget DECIMAL(12,2)
);

-- Major departments fragment
CREATE TABLE minor_departments (
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

-- Active faculty fragment
CREATE TABLE retired_faculty (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    status VARCHAR(20) DEFAULT 'Retired'
);

-- Active faculty fragment
CREATE TABLE onleave_faculty (
    faculty_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    status VARCHAR(20) DEFAULT 'On Leave'
);