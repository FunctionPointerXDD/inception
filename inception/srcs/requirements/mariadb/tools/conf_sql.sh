#!/bin/sh

rc-service mariadb setup
rc-service mariadb start

mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';" && \
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" && \
mysql -e "FLUSH PRIVILEGES;" && \
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
rc-service mariadb restart
