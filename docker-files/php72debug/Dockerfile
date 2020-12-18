FROM php:7.2-fpm
RUN apt-get update -y && apt-get install -y sendmail libpng-dev 
RUN apt-get install libxslt-dev -y
RUN apt-get install libmcrypt-dev -y
RUN apt-get update && apt-get install -y libfreetype6-dev  libjpeg62-turbo-dev libpng-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd  pdo pdo_mysql  xsl intl soap zip sockets bcmath mysqli     
RUN pecl install xdebug-2.6.0 
RUN docker-php-ext-enable xdebug
RUN php -i
    
    
