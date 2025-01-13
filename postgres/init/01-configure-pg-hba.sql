-- Update pg_hba.conf through SQL
ALTER SYSTEM SET listen_addresses TO '*';
-- Trust local connections
ALTER SYSTEM SET password_encryption TO 'md5';