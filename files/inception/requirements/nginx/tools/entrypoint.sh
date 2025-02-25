#!/bin/sh

if [ ! -f ~/ssl ]; then
	sed -i -e "s/%DOMAIN_NAME%/$DOMAIN_NAME/g" /etc/nginx/sites-enabled/wordpress.conf

	nginx

	certbot run -n --agree-tos -d $DOMAIN_NAME -m wouhliss@student.42.fr --redirect --nginx

	touch ~/ssl

	nginx -s stop
fi

nginx -g 'daemon off;'
