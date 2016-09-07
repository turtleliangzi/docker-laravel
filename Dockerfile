FROM ubuntu:16.04

MAINTAINER turtle "turtle@anasit.com"

RUN \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
        apt-get update && \
        apt-get install -y mariadb-server mariadb-common && \
        apt-get install -y php && \
        apt-get install -y nginx && \
        apt-get install -y vim && \
        apt-get install -y supervisor


RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisord.conf

# 配置nginx

Copy ./default /etc/nginx/sites-available/default


CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 3306
EXPOSE 80
