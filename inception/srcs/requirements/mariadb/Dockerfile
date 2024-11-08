FROM alpine:3.19

RUN apk update && apk add --no-cache mysql mysql-client openrc

# make dir and authorize 
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod -R 755 /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# use "openrc" instead of systemd
RUN mkdir -p /run/openrc && \
    touch /run/openrc/softlevel && \
    openrc

# ENV INNODB_BUFFER_POOL_SIZE=256M

ADD tools/init_sql.sh .
RUN chmod +x /init_sql.sh && ./init_sql.sh

#open db port -> it is only connect docker network.
EXPOSE 3306

# mysqld -> mariadb's daemon process ==> "root"
# mysql ->  default user
# --console ==> persist mysql on foreground && print db logs.
ENTRYPOINT [ "mysqld", "--user=mysql", "--console" ]
