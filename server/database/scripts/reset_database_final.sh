#!/bin/bash
set -euo pipefail

db_name="TecnoComponentes_BD"
script_dir=$(dirname "$0")

DB_CMD="mariadb -h 127.0.0.1 -P 3306 -u root --password=pass_root"

$DB_CMD -v -e "
    DROP DATABASE IF EXISTS \`${db_name}\`;
    CREATE DATABASE \`${db_name}\`;
" && echo

$DB_CMD "$db_name" < "${script_dir}/db_tables.sql" && echo
$DB_CMD "$db_name" < "${script_dir}/db_procedures.sql" && echo
$DB_CMD "$db_name" < "${script_dir}/db_test_data.sql" && echo
