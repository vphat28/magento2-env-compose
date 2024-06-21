FROM php:7.4-fpm
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
RUN apt-get install cron -y
RUN apt-get install libmcrypt-dev -y
RUN apt-get install git -y
<<<<<<< HEAD
RUN apt-get update && apt install mariadb-client -y
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo mysqli pdo_mysql zip xsl intl soap bcmath   
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
=======
RUN apt-get install wget -y
RUN wget https://getcomposer.org/download/latest-stable/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chown root:www-data /usr/local/bin/composer
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo mysqli pdo_mysql zip xsl intl soap bcmath   
RUN chmod 775 /usr/local/bin/composer
RUN mkdir /var/www/.composer
RUN chmod 777 /var/www/.composer
>>>>>>> f291e8adac8b17dca3914af2b1bb804a4b50c602
RUN docker-php-ext-install sockets
RUN php -i
