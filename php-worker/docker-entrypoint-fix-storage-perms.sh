#!/bin/sh
set -e

# El cron container corre backup:run como root (ver cron.dockerfile), mientras
# que este worker corre queue:work como el usuario laravel (UID 1000, ver
# queue-worker.ini). Si el cron crea storage/app/backup-temp antes que el
# worker, queda root-owned y el job manual falla con "mkdir(): Permission
# denied". Normalizamos el dueño en cada arranque, igual que el entrypoint
# del contenedor php hace con el symlink de storage.
mkdir -p /var/www/html/storage/app/backup-temp
chown -R laravel:laravel /var/www/html/storage/app/backup-temp

exec "$@"
