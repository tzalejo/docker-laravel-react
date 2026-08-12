#!/bin/sh
set -e

# public/ vive en el volumen bind-mounteado del proyecto, no en la imagen,
# asi que el symlink no sobrevive a un build y hay que crearlo en cada
# arranque del contenedor (storage:link es idempotente con --force).
php artisan storage:link --force

exec docker-php-entrypoint "$@"
