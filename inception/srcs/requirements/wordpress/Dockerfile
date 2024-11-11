FROM alpine:3.19

RUN apk add php82-fpm \
    php82-mysqli \
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
    PHP_CGI_FIX_PATHINFO=0

ADD tools/init_php.sh /scripts/init_php.sh
RUN chmod -R 755 /scripts 

EXPOSE 9000

ENTRYPOINT [ "/scripts/init_php.sh" ]