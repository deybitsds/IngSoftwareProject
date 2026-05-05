#!/bin/bash
set -euo pipefail

# --- CONFIG ---
db_user="mariadbuser"
db_passwd="mariadbuser"
db_name="TecnoComponentes_BD"
db_ipaddr="%"
root_pass="pass_root"

script_dir=$(dirname "$0")

# --- START CONTAINER ---
docker run -d \
  --name mariadb-Test \
  -e MARIADB_ROOT_PASSWORD=${root_pass} \
  -p 3306:3306 \
  mariadb:latest

# Wait a bit for MariaDB to be ready
echo "Waiting for MariaDB to start..."
sleep 10

DB_CMD="mariadb -h 127.0.0.1 -P 3306 -u root --password=${root_pass}"

# --- CREATE DB + USER ---
$DB_CMD -v -e "
  CREATE DATABASE IF NOT EXISTS \`${db_name}\`;
  DROP USER IF EXISTS '${db_user}'@'${db_ipaddr}';
  CREATE USER '${db_user}'@'${db_ipaddr}' IDENTIFIED BY '${db_passwd}';
  GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON \`${db_name}\`.* TO '${db_user}'@'${db_ipaddr}';
  FLUSH PRIVILEGES;
"

# --- RESET DATABASE (optional but kept from your script) ---
$DB_CMD -v -e "
  DROP DATABASE IF EXISTS \`${db_name}\`;
  CREATE DATABASE \`${db_name}\`;
"

# --- LOAD SCHEMA & DATA ---
$DB_CMD "$db_name" < "${script_dir}/db_tables.sql"
$DB_CMD "$db_name" < "${script_dir}/db_procedures.sql"
$DB_CMD "$db_name" < "${script_dir}/db_test_data.sql"

echo "Database setup complete."
