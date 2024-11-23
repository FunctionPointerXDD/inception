FROM alpine:3.19

RUN apk update && apk add nginx openssl
RUN adduser -D -g 'www' www
RUN mkdir -p /www && \
    chown -R www:www /var/lib/nginx /www && \
    chmod -R 755 /www
    
#COPY -> release
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /www

ADD tools/init_nginx.sh /scripts/init_nginx.sh
RUN chmod -R 755 /scripts

EXPOSE 443 

ENTRYPOINT [ "scripts/init_nginx.sh" ]
