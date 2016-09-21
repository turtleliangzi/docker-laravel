service nginx start
service mysql start
service php7.0-fpm start
cd /var/www/laravel
chmod -R 777 storage bootstrap/cache
