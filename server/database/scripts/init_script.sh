#!/bin/bash
set -euo pipefail

# --- CONFIG ---
db_user="mariadbuser"
db_passwd="mariadbuser"
db_name="TecnoComponentes_BD"
db_ipaddr="%"
root_pass="pass_root"
container_name="tecomp_bd_container"
script_dir=$(dirname "$0")

# --- START CONTAINER ---
docker run -d \
  --name "${container_name}" \
  -e MARIADB_ROOT_PASSWORD="${root_pass}" \
  -p 3306:3306 \
  mariadb:latest

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until docker exec "${container_name}" mariadb -u root --password="${root_pass}" -e "SELECT 1" &>/dev/null; do
  sleep 1
done
echo "MariaDB is ready."

DB_CMD="docker exec -i ${container_name} mariadb -h 127.0.0.1 -P 3306 -u root --password=${root_pass}"

# --- RESET DATABASE ---
$DB_CMD -v -e "
  DROP DATABASE IF EXISTS \`${db_name}\`;
  CREATE DATABASE \`${db_name}\`;
"

# --- CREATE USER & GRANT PERMISSIONS ---
$DB_CMD -v -e "
  DROP USER IF EXISTS '${db_user}'@'${db_ipaddr}';
  CREATE USER '${db_user}'@'${db_ipaddr}' IDENTIFIED BY '${db_passwd}';
  GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON \`${db_name}\`.* TO '${db_user}'@'${db_ipaddr}';
  FLUSH PRIVILEGES;
"

# --- LOAD SCHEMA & DATA ---
$DB_CMD "${db_name}" < "${script_dir}/db_tables.sql"
$DB_CMD "${db_name}" < "${script_dir}/db_procedures.sql"
$DB_CMD "${db_name}" < "${script_dir}/db_test_data.sql"

echo "Database setup complete."
