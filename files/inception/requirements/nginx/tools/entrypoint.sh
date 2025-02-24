#!/bin/sh

if [ ! -f ~/ssl ]; then
	nginx

	certbot run -n --agree-tos -d cloud-1.acorp.games,phpmyadmin.cloud-1.acorp.games -m wouhliss@student.42.fr --redirect --nginx

	touch ~/ssl

	nginx -s stop
fi

nginx -g 'daemon off;'
