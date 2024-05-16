FROM php:8.2-fpm
#RUN pecl install xdebug-3.3.1
#docker-php-ext-enable xdebug
USER root

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        libpq-dev \
        git \
        zip \
        curl \
        nodejs \
        npm \
        unzip \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install exif \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pgsql \
    && docker-php-ext-install pdo_pgsql \
    #&& docker-php-ext-enable xdebug \
    && docker-php-source delete \

COPY ./src /var/www/html

COPY ./src/.env /var/www/html/.env
COPY /php/90-xdebug.ini /usr/local/etc/php/conf.d
COPY /php/90-default.ini /usr/local/etc/php/conf.d
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80 443