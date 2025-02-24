#!/bin/sh

if [ ! -f "/mnt/data/db/mysql_upgrade_info" ]; then
	mariadb-install-db --user=mysql --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.cnf

	chown -R mysql:mysql /mnt/data/db

	touch /tmp/mariadb.sql

	echo "CREATE DATABASE $MYSQL_DATABASE;" >> /tmp/mariadb.sql

	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /tmp/mariadb.sql

	echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> /tmp/mariadb.sql

	echo "FLUSH PRIVILEGES;" >> /tmp/mariadb.sql

	service mariadb start

	mariadb -h localhost -w -S /var/lib/mysql/mysql.sock < /tmp/mariadb.sql && rm -f /tmp/mariadb.sql
else
	mariadbd --defaults-file=/etc/mysql/mariadb.conf.d/mariadb.cnf --user=mysql
fi
