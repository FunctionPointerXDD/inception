#!/bin/sh
adduser -D -g 'www' www
mkdir -p /www/wordpress
chown -R www:www /www /www/wordpress
chmod -R 755 /www /www/wordpress

#wait mariadb setting...
sleep 3

cd /www/wordpress

wp core download --allow-root

wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

wp core install \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$WORDPRESS_DB_ROOT_USER \
    --admin_password=$WORDPRESS_DB_ROOT_PASSWORD \
    --admin_email="asdf@asdf.com" \
    --skip-email \
    --allow-root

wp user create $WORDPRESS_DB_USER test@test.com --role=author --user_pass=$WORDPRESS_DB_PASSWORD --allow-root

rm -f wp-config-sample.php

sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php82/php-fpm.d/www.conf && \
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php82/php-fpm.d/www.conf && \
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php82/php-fpm.d/www.conf && \
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php82/php-fpm.d/www.conf && \
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php82/php-fpm.d/www.conf && \
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php82/php-fpm.d/www.conf

sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php82/php.ini && \
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php82/php.ini && \
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php82/php.ini && \
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php82/php.ini && \
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php82/php.ini && \
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php82/php.ini && \
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php82/php.ini && \
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php82/php.ini 

sed -i 's|;clear_env = no|clear_env = no|g' /etc/php82/php-fpm.d/www.conf

sed -i 's/^listen = 127\.0\.0\.1:9000$/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf

echo "<?php phpinfo(); ?>" > /www/wordpress/phpinfo.php

exec /usr/sbin/php-fpm82 -FR
