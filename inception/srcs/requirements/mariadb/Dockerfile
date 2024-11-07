FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache mysql mysql-client openrc

# make dir and authorize 
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# config mariaDB & init data directory
# RUN mysqld --initialize --user=mysql --datadir=/var/lib/mysql

# use "openrc" instead of systemd
# auto start mariadb after reboot -> cmd: "rc-updqte add mairadb default"
RUN mkdir -p /run/openrc && \
    touch /run/openrc/softlevel && \
    rc-update add mariadb default && \
    rc-service mariadb setup

EXPOSE 3306

#ENTRYPOINT [ "mysqld" ]