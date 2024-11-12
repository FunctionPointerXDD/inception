FROM alpine:3.19

RUN apk add --no-cache \
                php82-fpm \
                php82-mysqli \
                php82 \
                fcgi \
                php82-cgi \
                wget \
                curl

ENV PHP_FPM_USER="www" \
    PHP_FPM_GROUP="www" \
    PHP_FPM_LISTEN_MODE="0660" \
    PHP_MEMORY_LIMIT="512M" \
    PHP_MAX_UPLOAD="50M" \
    PHP_MAX_FILE_UPLOAD="200" \
    PHP_MAX_POST="100M" \
    PHP_DISPLAY_ERRORS="On" \
    PHP_DISPLAY_STARTUP_ERRORS="On" \
    PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR" \
    PHP_CGI_FIX_PATHINFO=0 \
    WORDPRESS_DB_HOST=chansjeo42 \
    WORDPRESS_DB_USER=chansjeo \
    WORDPRESS_DB_PASSWORD=1234567890 \
    WORDPRESS_DB_NAME=wordpress_db
    
ADD tools/init_php.sh /scripts/init_php.sh
RUN chmod -R 755 /scripts 

STOPSIGNAL SIGQUIT

EXPOSE 9000
ENTRYPOINT [ "/scripts/init_php.sh" ]