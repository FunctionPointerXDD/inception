#!/bin/sh

rc-service mariadb setup
rc-service mariadb start

mysql -u $(MYSQL_ROOT_USER) <<EOF
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO '$(MYSQL_ROOT_USER)'@'%' identified by '$(MYSQL_ROOT_PASSWORD)' WITH GRANT OPTION ;
GRANT ALL ON *.* TO '$(MYSQL_ROOT_USER)'@'localhost' identified by '$(MYSQL_ROOT_PASSWORD)' WITH GRANT OPTION ;
SET PASSWORD FOR '$(MYSQL_ROOT_USER)'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF

mysql_secure_installation <<EOF
y
password
password
y
y
y
y
EOF

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf
sed -i "s|^skip-networking|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

rc-service mariadb restart
rc-service mariadb stop

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@
