FROM php:7.3-fpm
RUN apt-get update && apt-get install -y libfreetype6-dev  libjpeg62-turbo-dev libpng-dev \
	&& docker-php-ext-configure gd \
	&& docker-php-ext-install gd 
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libzip-dev \
        libpng-dev 
RUN apt-get update -y && apt-get install -y sendmail libpng-dev 
RUN apt-get install libxslt-dev -y
RUN apt-get install git -y
RUN apt-get install libmcrypt-dev -y
RUN  docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install opcache
RUN docker-php-ext-install  pdo_mysql mysqli_client  xsl intl soap zip sockets bcmath   
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include
RUN docker-php-ext-install gd 
RUN php -i
    
    

