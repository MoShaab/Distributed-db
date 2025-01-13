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
FROM SERVER mssql_server
INTO public;