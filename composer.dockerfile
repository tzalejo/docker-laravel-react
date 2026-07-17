ARG COMPOSER_VERSION
FROM composer:${COMPOSER_VERSION}

RUN docker-php-ext-install bcmath

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

WORKDIR /var/www/html