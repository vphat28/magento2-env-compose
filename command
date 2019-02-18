docker run --name nginx -v $PWD/nginx-conf:/etc/nginx/conf.d --network=charper -v $PWD/www:/var/www/html -d nginx

docker run -d  --name php72 --expose 9000 \
    --network=charper -v $PWD/www:/var/www/html \
    php:7.2-fpm

docker run -d  --name php71 --expose 9000 \
    --network=charper -v $PWD/www:/var/www/html \
    php:7.1-fpm

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


docker run --name mysql --network=charper -v $PWD/mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root  mysql:5.7 
