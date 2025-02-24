FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	curl \
	gnupg2 \
	ca-certificates \
	lsb-release \
	debian-archive-keyring \
	python3 \
	python3-venv \
	libaugeas0

RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
	| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
	http://nginx.org/packages/debian `lsb_release -cs` nginx" \
	| tee /etc/apt/sources.list.d/nginx.list

RUN apt-get update && apt-get install -y \
	openssl \
	nginx

RUN python3 -m venv /opt/certbot/ && /opt/certbot/bin/pip install --upgrade pip

RUN /opt/certbot/bin/pip install certbot certbot-nginx

RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot

COPY conf/nginx.conf /etc/nginx/

COPY conf/fastcgi.conf /etc/nginx/

COPY conf/mime.types /etc/nginx/conf/

COPY conf/cloud-1.acorp.games.conf /etc/nginx/sites-enabled/
COPY conf/phpmyadmin.cloud-1.acorp.games.conf /etc/nginx/sites-enabled/

COPY tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 443

CMD ["/entrypoint.sh"]
