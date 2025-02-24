FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	php \
	php-mysql \
	php-curl \
	php-gd \
	php-intl \
	php-mbstring \
	php-soap \
	php-xml \
	php-xmlrpc \
	php-zip \
	php-fpm \
	wget

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \ 
    chmod +x wp-cli.phar

COPY conf/wordpress_pool.conf /etc/php/7.4/fpm/pool.d/

COPY tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

RUN groupadd wordpress_user

RUN useradd -g wordpress_user wordpress_user

RUN usermod -aG www-data wordpress_user

RUN mkdir -p /run/php

RUN touch /run/php/php7.4-fpm.sock

EXPOSE 9000

CMD ["/entrypoint.sh"]