FROM alpine:3.19

RUN apk add --no-cache mysql && \
    rm -f /var/cache/apk/*

ADD tools/init_sql.sh /scripts/init_sql.sh
RUN chmod -R 755 /scripts

#mount 'host data dir path' to 'container data dir path'
VOLUME [ "/var/lib/mysql" ]

#open db port -> it is only connect docker network.
EXPOSE 3306

ENV MYSQL_ROOT_USER=chansjeo42 \
    MYSQL_ROOT_PASSWORD=1234567890 \
    MYSQL_USER=chansjeo \
    MYSQL_PASSWORD=1234567890 \
    MYSQL_DATABASE=wordpress_db

ENTRYPOINT [ "/scripts/init_sql.sh" ]

# ip: 172.17.0.2
