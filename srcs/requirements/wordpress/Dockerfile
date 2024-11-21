FROM alpine:3.19

RUN apk add --no-cache \
                php82-fpm \
                php82-mysqli \
                wget \
                curl \
                php \
                php-phar \
                php82-mbstring

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ADD tools/init_php.sh /scripts/init_php.sh
RUN chmod -R 755 /scripts

EXPOSE 9000

ENTRYPOINT [ "/scripts/init_php.sh" ]
