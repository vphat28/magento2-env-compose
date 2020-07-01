docker run --name tengine -v $PWD/nginx-conf:/etc/tengine/conf.d --network=charper -v $PWD/www:/var/www/html -d --ip 172.22.0.88 shuliyey/tengine:latest

 docker run --name openresty -v $PWD/nginx-conf:/etc/nginx/conf.d --network=charper -v $PWD/www:/var/www/html -p 80:80 -d --ip 172.22.0.88  openresty/openresty:alpine



docker run --name nginx -v $PWD/nginx-conf:/etc/nginx/conf.d --network=charper -v $PWD/www:/var/www/html  -d --ip 172.22.0.88  nginx

docker run -d  --name php72 --expose 9000 \
    --network=charper -v $PWD/www:/var/www/html \
    php:7.2-fpm

docker run -d  --name php71debug --expose 9000 -e  XDEBUG_CONFIG="remote_host=192.168.1.116 remote_enable=on remote_autostart=on remote_port=9300 force_display_errors=on"  \
    --network=charper -v $PWD/www:/var/www/html \
    vphat28/php71


docker run -d  --name php72 --expose 9000 -e  XDEBUG_CONFIG="remote_host=192.168.1.106 remote_enable=on remote_autostart=on remote_port=9300 force_display_errors=on"  \
    --network=charper -v $PWD/www:/var/www/html \
    vphat28/php72
docker run -d  --name php5.5 --expose 9000 \
    --network=charper -v $PWD/www:/var/www/html \
    5.5.35-fpm
 
apt-get update && apt-get install -y libfreetype6-dev  libjpeg62-turbo-dev libpng-dev \
	&& docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd

apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

apt-get update -y && apt-get install -y sendmail libpng-dev

apt-get install libxslt-dev
apt-get install libmcrypt-dev
docker-php-ext-install gd pdo pdo_mysql  xsl intl soap zip bcmath mcrypt


pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug

docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

docker run --name mysql --network=charper -v $PWD/mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root  mysql:5.7 


docker run --name composer --interactive --tty     --volume $PWD:/app     --volume $COMPOSER_HOME:/tmp     composer require stripe/stripe-php

docker cp php.ini php71:/usr/local/etc/php

