FROM alpine:3.19

RUN apk add --no-cache mysql mysql-client && \
    rm -f /var/cache/apk/*

# make dir and authorize 
# RUN mkdir -p /var/lib/mysql && \
#     chown -R mysql:mysql /var/lib/mysql && \
#     chmod -R 755 /var/lib/mysql && \
#     mkdir -p /run/mysqld && \
#     chown -R mysql:mysql /run/mysqld


# use "openrc" instead of systemd
# RUN mkdir -p /run/openrc && \
#     touch /run/openrc/softlevel && \
#     openrc

# ENV INNODB_BUFFER_POOL_SIZE=256M

ADD tools/init_sql.sh /scripts/init_sql.sh
RUN chmod -R 755 /scripts

VOLUME [ "/var/lib/mysql" ]

#open db port -> it is only connect docker network.
EXPOSE 3306

ENV MYSQL_ROOT_USER=root \
    MYSQL_ROOT_PASSWORD=1234567890 \
    MYSQL_USER=chansjeo \
    MYSQL_PASSWORD=1234567890 \
    MYSQL_DATABASE=wordpress_db

#172.17.0.2
# mysqld -> mariadb's daemon process ==> "root"
# mysql ->  default user
# --console ==> persist mysql on foreground && print db logs.

ENTRYPOINT [ "/scripts/init_sql.sh" ]