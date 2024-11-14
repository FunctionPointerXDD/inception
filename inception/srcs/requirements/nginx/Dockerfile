FROM alpine:3.19

RUN apk update && apk add nginx=1.24.0-r16
RUN adduser -D -g 'www' www
RUN mkdir -p /www && \
    chown -R www:www /var/lib/nginx /www && \
    chmod -R 755 /www
    
#todo -> delete 80
EXPOSE 80 443 

#COPY -> release
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /www

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

# shell script 로 변경?


