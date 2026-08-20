ARG APP_PHP_VERSION=8.4
ARG APP_PHP_VARIANTE=fpm-alpine
FROM php:${APP_PHP_VERSION}-${APP_PHP_VARIANTE}
LABEL maintainer="tzalejo@gmail.com"
LABEL version="1.0"

RUN set -e; \
        apk add --no-cache \
        postgresql-dev \
        postgresql16-client \
        libzip-dev \
        gzip

RUN docker-php-ext-install pdo pgsql pdo_pgsql zip

# Mismo UID que los usuarios 'laravel' de php/worker.dockerfile: si el cron
# corriera como root, los archivos que crea (storage/app/backup-temp,
# storage/logs/backup-*.log) quedan root-owned y el queue-worker (que si
# corre como 'laravel') no puede escribirlos despues. crond en si sigue
# corriendo como root (lo necesita busybox para hacer setuid por crontab),
# pero el job del crontab de 'laravel' corre como ese usuario.
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

COPY crontab /etc/crontabs/laravel
RUN chmod 600 /etc/crontabs/laravel

CMD ["crond", "-f"]
