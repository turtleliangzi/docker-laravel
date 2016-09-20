# nginx

service nginx start

# mysql

service mysql start

# php7.0-fpm

service php7.0-fpm start

# laravel

cd /var/www/laravel
chmod -R 777 storage bootstrap/cache

mysql -uroot -p -e create database laravel

mysql -uroot -p laravel < /var/www/laravel/sqlfile.sql
