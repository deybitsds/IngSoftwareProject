db_user="mariadbuser"
db_passwd="mariadbuser"
db_name="TecnoComponentes_BD"
db_ipaddr="%"

# read -s -p "Enter MariaDB root password: " passwd
echo

mariadb -h 127.0.0.1 -P 3306 -u root --password="your_root_password" -v -e "
  CREATE DATABASE IF NOT EXISTS \`${db_name}\`;
  DROP USER IF EXISTS '${db_user}'@'${db_ipaddr}';
  CREATE USER '${db_user}'@'${db_ipaddr}' IDENTIFIED BY '${db_passwd}';
  GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE ON \`${db_name}\`.* TO '${db_user}'@'${db_ipaddr}';
  FLUSH PRIVILEGES;
"
