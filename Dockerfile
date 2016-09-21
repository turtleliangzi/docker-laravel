FROM ubuntu:latest

MAINTAINER turtle "turtle@anasit.com"

RUN cp /etc/apt/sources.list /etc/apt/sources.list_backup

COPY sources.list /etc/apt/sources.list

RUN \
        apt-get clean && \
        apt-get update && \
        apt-get install -y vim && \
        apt-get install -y mariadb-server mariadb-common && \
        apt-get install -y php php-mysql && \
        apt-get install -y nginx && \
        apt-get install -y supervisor


RUN mkdir -p /var/log/supervisor

# 搭建laravel开发环境

RUN \
        apt-get install -y curl && \
        curl -sS http://getcomposer.org/installer | php && \
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

# 添加启动脚本
ADD run.sh /run.sh
RUN chmod 755 /run.sh

#添加同步数据脚本
ADD db_rsync.sh /db_rsync.sh
RUN chmod 755 /db_rsync.sh


ADD supervisord.conf /etc/supervisord.conf

# 配置nginx

Copy ./default /etc/nginx/sites-available/default


# 创建laravel数据库

RUN \
        service mysql start && \
        mysql -e "create database laravel default charset utf8" && \
        mysql -e "create user 'laravel'@'localhost' identified by 'laravel'" && \
        mysql -e "grant all on laravel.* to 'laravel'@'localhost'"


CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 3306
EXPOSE 80
