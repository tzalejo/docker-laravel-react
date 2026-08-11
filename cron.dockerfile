ARG APP_PHP_VERSION=8.4
ARG APP_PHP_VARIANTE=fpm-alpine
FROM php:${APP_PHP_VERSION}-${APP_PHP_VARIANTE}
LABEL maintainer="tzalejo@gmail.com"
LABEL version="1.0"

RUN set -e; \
        apk add --no-cache \
        postgresql-dev

RUN docker-php-ext-install pdo pgsql pdo_pgsql
COPY crontab /etc/crontabs/root
CMD ["crond", "-f"]
