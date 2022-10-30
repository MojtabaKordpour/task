# FROM php:8.2-apache
FROM php:8.1-rc-apache-buster
# FROM php:8.2-rc-apache-buster
# FROM php:8.2-rc-zts-buster

RUN apt update \
    && apt install -y \
    libcurl4-openssl-dev \ 
    pkg-config \
    libssl-dev \
    g++ \
    libicu-dev \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libgd-dev \
    libonig-dev \
    libxml2-dev \
    jpegoptim optipng pngquant gifsicle \
    zip \
    npm \
    && docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    intl \
    opcache \
    pdo_pgsql \
    pgsql \
    zip \ 
    bcmath

RUN apt-get update -y && apt-get install -y sendmail libpng-dev

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd



# RUN pecl install mongodb
# RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini
RUN a2enmod rewrite

WORKDIR /var/www/app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install supervisor -y
#COPY ./supervisor-data/laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

#CMD supervisord -c /etc/supervisor/supervisord.conf