#!/bin/sh

#create mysqld process directory -> use socket connecting
if [ -d "/run/mysqld" ]; then
    echo "[i] mysqld already present, skipping creation"
    chown -R mysql:mysql /run/mysqld
else
    echo "[i] mysqld not found, creating..."
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

#create db directory
if [ -d /var/lib/mysql/mysql ]; then
    echo "[i] MySQL directory already present, skipping creation"
    chown -R mysql:mysql /var/lib/mysql
else    
    echo "[i] MySQL data directory not found, creating initial DBs"

    chown -R mysql:mysql /var/lib/mysql

    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

    # make tmp file for setting root id and password
    tfile=$(mktemp)
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR '$MYSQL_ROOT_USER'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF

#make init database and make user id and password
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE" >> $tfile
echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile

# /usr/bin/mysqld : run mysqld process through "absolute path value"
# --user=mysql : default user is mysql(not root) --> security purpose
# --bootstrap : init database option (No actual running!)
# --verbose=0 : minimize logs recording
# --skip-name-resolve : ip address is not transefer to hostname. Only use ip address to connect 
# --skip-networking=0 : allow external access to server (like "bind-address=0.0.0.0")
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
rm -f $tfile

fi

# "exec" : repalce init_sql.sh process to "mysqld" process (shell is over)
# -> and running "mysqld" in foreground. (PID 1 is "mysqld")
# -> There is no need "tini" or "dumb-init" process.
# --console : logging to stdout

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@

