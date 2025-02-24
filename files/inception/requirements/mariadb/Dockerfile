FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-client

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf

COPY tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 3306

CMD ["/entrypoint.sh"]