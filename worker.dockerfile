ARG APP_PHP_VERSION=8.4
ARG APP_PHP_VARIANTE=fpm-alpine
FROM php:${APP_PHP_VERSION}-${APP_PHP_VARIANTE}
LABEL maintainer="tzalejo@gmail.com"
LABEL version="1.0"
ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

RUN set -e; \
         apk add --no-cache \
                coreutils \
                freetype-dev \
                libjpeg-turbo-dev \
                libjpeg-turbo \
                libpng-dev \
                libzip-dev \
                jpeg-dev \
                icu-dev \
                zlib-dev \
                curl-dev \
                libxslt-dev libxml2-dev \
                postgresql-dev \
                oniguruma-dev \
                sqlite-dev \
                supervisor

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-configure intl
RUN docker-php-ext-install curl pdo pdo_pgsql pdo_sqlite exif gd intl zip bcmath

COPY supervisord.conf /etc/supervisord.conf
