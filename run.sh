# nginx

service nginx start

# mysql

service mysql start

# php7.0-fpm

service php7.0-fpm start

# laravel

cd /var/www/laravel
chmod -R 777 storage bootstrap/cache

mysql -e "create database laravel default charset utf8"

mysql laravel < /var/www/laravel/sqlfile.sql
