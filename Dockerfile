FROM ubuntu:latest

MAINTAINER turtle "turtle@anasit.com"

RUN cp /etc/apt/sources.list /etc/apt/sources.list_backup

COPY sources.list /etc/apt/sources.list

RUN \
        apt-get clean && \
        apt-get update && \
        apt-get install -y vim && \
        apt-get install -y mariadb-server mariadb-common && \
        apt-get install -y php && \
        apt-get install -y nginx && \
        apt-get install -y supervisor


RUN mkdir -p /var/log/supervisor

# 搭建laravel开发环境

RUN \
        apt-get install -y curl && \
        curl -sS https://getcomposer.org/installer | php && \
        mv composer.phar /usr/local/bin/composer && \
        apt-get install -y git && \
        apt-get install -y zip && \
        apt-get install -y php-zip && \
        apt-get install -y php-mbstring && \
        apt-get install -y php-dom && \
        composer global require "laravel/installer"


ENV PATH $PATH:~/.composer/vendor/bin

# 新建laravel web目录
RUN mkdir -p /var/www/laravel
ADD run.sh /root/run.sh


ADD supervisord.conf /etc/supervisord.conf

# 配置nginx

Copy ./default /etc/nginx/sites-available/default


CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 3306
EXPOSE 80
