FROM alpine:3.19

RUN apk add --no-cache mysql mysql-client && \
    rm -f /var/cache/apk/*

ADD tools/init_sql.sh /scripts/init_sql.sh
RUN chmod -R 755 /scripts

#open db port -> it is only connect docker network.
EXPOSE 3306

ENTRYPOINT [ "/scripts/init_sql.sh" ]
