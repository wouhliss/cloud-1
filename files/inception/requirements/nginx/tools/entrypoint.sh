#!/bin/sh

if [ ! -f /etc/letsencrypt/has_tls ]; then
	sed -i -e "s/%DOMAIN_NAME%/$DOMAIN_NAME/g" /etc/nginx/sites-enabled/wordpress.conf

	nginx

	certbot run -n --agree-tos -d $DOMAIN_NAME -m wouhliss@student.42.fr --redirect --nginx

	touch /etc/letsencrypt/has_tls

	nginx -s stop
else
	nginx -g 'daemon off;'
fi