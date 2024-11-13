FROM alpine:3.19

RUN apk update && apk add nginx=1.24.0-r16
RUN adduser -D -g 'www' www
RUN mkdir -p /www /www/nginx
RUN chown -R www:www /var/lib/nginx /www /www/nginx
    

#todo -> delete 80
EXPOSE 80 443 

#COPY -> release
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /www/nginx

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]


