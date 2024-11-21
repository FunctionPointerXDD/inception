FROM alpine:3.19

RUN apk add --no-cache \
                php82-fpm=8.2.20-r0 \
                php82-mysqli=8.2.20-r0 \
                wget=1.21.4-r0 \
                curl=8.9.1-r1 \
                php82=8.2.20-r0 \
                php82-phar=8.2.20-r0 \
                php82-mbstring=8.2.20-r0

# install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ADD tools/init_php.sh /scripts/init_php.sh
RUN chmod -R 755 /scripts

EXPOSE 9000

ENTRYPOINT [ "/scripts/init_php.sh" ]
