-- Create link to MySQL (for enrollments and grades)

DROP SERVER IF EXISTS mysql_server CASCADE;
DROP SERVER IF EXISTS mssql_server CASCADE;

CREATE SERVER mysql_server
FOREIGN DATA WRAPPER mysql_fdw
OPTIONS (host 'university_mysql', port '3306');

CREATE USER MAPPING FOR admin
SERVER mysql_server
OPTIONS (username 'admin', password 'secure_mysql_pwd');

-- Create foreign tables for MySQL data

IMPORT FOREIGN SCHEMA university_db
FROM SERVER mysql_server
INTO public;


-- CREATE FOREIGN TABLE foreign_enrollments (
--     enrollment_id INT,
--     student_id INT,
--     course_id INT,
--     semester VARCHAR(20)
-- ) SERVER mysql_server OPTIONS (table_name 'current_enrollments');



-- Create link to MSSQL

CREATE SERVER mssql_server
FOREIGN DATA WRAPPER tds_fdw
OPTIONS (servername 'university_mssql', port '1433', database 'university_db');

CREATE USER MAPPING FOR admin
SERVER mssql_server
OPTIONS (username 'sa', password 'SecureSQL2022Pwd');

IMPORT FOREIGN SCHEMA university_db
FROM SERVER mysql_server
INTO public;







-- Drop existing foreign tables if they exist
DROP FOREIGN TABLE IF EXISTS active_grades;
DROP FOREIGN TABLE IF EXISTS completed_enrollments;
DROP FOREIGN TABLE IF EXISTS enrollments;
DROP FOREIGN TABLE IF EXISTS current_enrollments;
DROP FOREIGN TABLE IF EXISTS  foreign_current_financial_records;
DROP FOREIGN TABLE IF EXISTS grades;
DROP FOREIGN TABLE IF EXISTS faculty;
DROP FOREIGN TABLE IF EXISTS retired_faculty;
DROP FOREIGN TABLE IF EXISTS onleave_faculty;
DROP FOREIGN TABLE IF EXISTS financial_records;
DROP FOREIGN TABLE IF EXISTS previous_financial_records;
DROP FOREIGN TABLE IF EXISTS historical_financial_records;


IMPORT FOREIGN SCHEMA university_db
FROM SERVER mysql_server
INTO public;

-- Create foreign table for departments

CREATE FOREIGN TABLE departments (
    department_id INT,
    department_name VARCHAR(100),
    budget DECIMAL(12,2)
    
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.departments'
    
);


CREATE FOREIGN TABLE major_departments (
    department_id INT,
    department_name VARCHAR(100),
    budget DECIMAL(15,2)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.major_departments'
    
);

CREATE FOREIGN TABLE minor_departments (
    department_id INT,
    department_name VARCHAR(100),
    budget DECIMAL(15,2)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.minor_departments'
    
);

-- Create foreign table for active_faculty
CREATE FOREIGN TABLE active_faculty (
    faculty_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    status VARCHAR(20)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.active_faculty'

);

-- Create foreign table for financial records
CREATE FOREIGN TABLE current_financial_records (
    record_id INT,
    department_id INT,
    budget_spent DECIMAL(15,2)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.current_financial_records'
    
);

-- Create foreign table for faculty
CREATE FOREIGN TABLE faculty (
    faculty_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    status VARCHAR(20)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.faculty'
);

-- Create foreign table for retired faculty
CREATE FOREIGN TABLE retired_faculty (
    faculty_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    status VARCHAR(20)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.retired_faculty'
);

-- Create foreign table for on-leave faculty
CREATE FOREIGN TABLE onleave_faculty (
    faculty_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    status VARCHAR(20)
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.onleave_faculty'
);

-- Create foreign table for financial records
CREATE FOREIGN TABLE financial_records (
    record_id INT,
    department_id INT,
    budget_spent DECIMAL(15,2),
    fiscal_year INT
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.financial_records'
);

-- Create foreign table for previous financial records
CREATE FOREIGN TABLE previous_financial_records (
    record_id INT,
    department_id INT,
    budget_spent DECIMAL(15,2),
    fiscal_year INT
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.previous_financial_records'
);

-- Create foreign table for historical financial records
CREATE FOREIGN TABLE historical_financial_records (
    record_id INT,
    department_id INT,
    budget_spent DECIMAL(15,2),
    fiscal_year INT
) SERVER mssql_server
OPTIONS (
    table_name 'dbo.historical_financial_records'
);
