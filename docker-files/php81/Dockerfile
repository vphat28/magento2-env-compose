FROM php:8.1-fpm
RUN apt-get update && apt-get install -y libfreetype6-dev  libjpeg62-turbo-dev libpng-dev \
	&& docker-php-ext-configure gd \
	&& docker-php-ext-install gd 
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
         libzip-dev \
        libjpeg62-turbo-dev \
        libpng-dev 
RUN apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick
RUN apt-get update -y && apt-get install -y sendmail libpng-dev 
RUN apt-get install libxslt-dev -y
RUN apt-get install libmcrypt-dev -y
RUN apt-get install git -y
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_mysql zip xsl intl soap bcmath   
RUN php -i
    
    
