FROM alpine:3.19

RUN apk update && apk add nginx=1.24.0-r16 openssl
RUN adduser -D -g 'www' www
RUN mkdir -p /www && \
    chown -R www:www /var/lib/nginx /www && \
    chmod -R 755 /www
    
EXPOSE 80 443 

#COPY -> release
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /www

RUN mkdir scripts && chmod -R 755 /scripts
ADD tools/init_nginx.sh /srcipts/init_nginx.sh

ENTRYPOINT [ "srcipts/init_nginx.sh" ]
