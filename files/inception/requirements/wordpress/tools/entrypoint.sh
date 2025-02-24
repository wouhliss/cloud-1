#!/bin/sh

if [ ! -d $WP_DIR ]; then
	/wp-cli.phar core download --path=$WP_DIR --allow-root
	touch /tmp/extraphp
	echo "define('WP_SITEURL', '$WP_URL');" > /tmp/extraphp
	echo "define('WP_CACHE', true);" >> /tmp/extraphp
	/wp-cli.phar config create	--dbhost=$MYSQL_HOST \
						--dbname=$MYSQL_DATABASE \
                    	--dbuser=$MYSQL_USER \
                    	--dbpass=$MYSQL_PASSWORD \
                    	--path=$WP_DIR \
						--url=$WP_URL \
                    	--allow-root \
                    	--skip-check \
						--extra-php < /tmp/extraphp && rm -f /tmp/extraphp
	/wp-cli.phar core install --title=$WP_TITLE \
                    --admin_user=$WP_ADMIN \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --path=$WP_DIR \
					--url=$WP_URL \
                    --allow-root
	chown -R www-data:www-data /mnt/data/www
	chmod -R 775 /mnt/data/www
	/wp-cli.phar user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=$WP_DIR --allow-root
fi

chown -R www-data:www-data /mnt/data/www

chmod -R 775 /mnt/data/www

php-fpm7.4 -F
