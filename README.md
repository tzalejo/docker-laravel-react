# Docker Laravel y React (Vite)

## Definir las variables de entorno
Copiar `.env-ejemplo` a `.env` y completar las variables. La base de datos es Postgres (unica BD soportada). Las variables de backend indican la version de PHP y Composer (tener en cuenta la version de Laravel a usar) y las de frontend la version de Node.

### Variable de base de datos: Postgres
- `POSTGRES_VERSION=`
- `POSTGRES_DB=`
- `POSTGRES_USER=`
- `POSTGRES_PASSWORD=`
- `POSTGRES_PORT=`
- `POSTGRES_ENTRYPOINT_INITDB=`
- `POSTGRES_VOLUMEN_PATH=`

### Variable Backend (Laravel)
- `APP_VOLUMEN_PATH=`
- `APP_PORT=`
- `APP_PHP_VERSION=8.4`
- `APP_PHP_VARIANTE=fpm-alpine`
- `COMPOSER_VERSION=2`

### Variable Frontend (Vite)
- `NPM_VOLUMEN_PATH=`
- `NPM_PORT=`
- `NPM_PORT_CONTAINER=`
- `NPM_NODE_VERSION=22`
- `NPM_NODE_VARIANTE=alpine`

Una vez definidas todas las variables de entorno, debemos crear el entorno con el comando:
- `docker-compose up -d --build`
Con esto ya estaria para continuar creando los proyectos de Laravel y frontend. Hay dos contenedores, `artisan` y `composer`, que utilizamos para ejecutar comandos.

## Crear proyecto laravel
- `docker-compose run --rm composer create-project --prefer-dist laravel/laravel .`
- `docker-compose run --rm composer create-project --prefer-dist laravel/laravel:^11.0 .` Si quiero especificar una version

## Los contenedores creados y sus puertos (si se usan) son los siguientes:

- `nginx - :${APP_PORT}`
- `pgsql - :${POSTGRES_PORT}`
- `php - :9000`
- `vite - :${NPM_PORT}`
- `cron` - ejecuta `php artisan schedule:run` cada minuto
- `supervisor-worker` - corre los queue workers definidos en `php-worker/supervisord.d/`

## Comando adicionales:

- `npm run install-dependencies` ejecutamos la instalaciones de todas las dependencias del backend y frontend
- `docker-compose -f docker-compose.prod.yml up -d --build` ejecutamos docker-compose production
- `docker-compose run --rm artisan (composer, npm) comando` ejecuta composer, npm, artisan dentro del contenedor
- `docker-compose exec {container_name} /bin/sh`
- `psql -U admin -d postgres -h localhost`
- `docker-compose run --rm artisan make:repository NombreModelo [--model=NombreModelo]` genera un repositorio en `app/Repositories/{Nombre}/{Nombre}Repository.php` siguiendo el patron de `AbstractRepository`

## Ngrok

- `./ngrok http APP_PORT -host-header="localhost:APP_PORT"`
- `./ngrok http --host-header=rewrite APP_PORT`

# Donaciones
- BTC: bc1q4je0jjmycfrfum4cgut48qdprvm02ahfshwwga
- ETH: 0x4804c6B390fC55BB6E6684216D1aDeD6B83e1198
