#!/bin/bash

set -e

unset npm_lifecycle_event
unset npm_lifecycle_script
unset npm_config_argv
unset npm_command

export N8N_PORT="$PORT"
export N8N_PROTOCOL="https"

export DB_TYPE="postgresdb"
export DB_POSTGRESDB_DATABASE="$POSTGRESQL_ADDON_DB"
export DB_POSTGRESDB_HOST="$POSTGRESQL_ADDON_HOST"
export DB_POSTGRESDB_PORT="$POSTGRESQL_ADDON_PORT"
export DB_POSTGRESDB_USER="$POSTGRESQL_ADDON_USER"
export DB_POSTGRESDB_PASSWORD="$POSTGRESQL_ADDON_PASSWORD"

export GENERIC_TIMEZONE="Europe/Paris"
export TZ="Europe/Paris"

export N8N_LISTEN_ADDRESS="${N8N_LISTEN_ADDRESS:-0.0.0.0}"

if [ -z "$N8N_HOST" ]; then
  export N8N_HOST="$(echo "$APP_ID" | tr '_' '-').cleverapps.io"
fi

echo "Host: $N8N_HOST"
echo "Port: $N8N_PORT"
echo "n8n version:"
./node_modules/.bin/n8n --version || true

echo "Starting n8n..."
exec env -u npm_lifecycle_event -u npm_lifecycle_script -u npm_config_argv -u npm_command ./node_modules/.bin/n8n
