FROM alpine:3.19

RUN apk add --no-cache \
                php82-fpm \
                php82-mysqli \
                wget \
                curl

RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /www

RUN wget https://wordpress.org/wordpress-6.7.tar.gz && \
    tar -xvf wordpress-6.7.tar.gz -C /www && \
    chown -R www:www /www/wordpress && \ 
    chmod -R 0644 /www/wordpress && \
    rm -rf /wordpress-6.7.tar.gz
    
ADD tools/init_php.sh /scripts/init_php.sh
RUN chmod -R 755 /scripts
COPY ./conf/wp-config.php /www/wordpress/wp-config.php
RUN chown -R www:www /www/wordpress && chmod -R 755 /www/wordpress

RUN mkdir wp-content; \
	for dir in /www/wordpress/wp-content/*/ cache; do \
		dir="$(basename "${dir%/}")"; \
		mkdir "wp-content/$dir"; \
	done; \
	chown -R www:www wp-content; \
	chmod -R 1777 wp-content

EXPOSE 9000

ENTRYPOINT [ "/scripts/init_php.sh" ]
