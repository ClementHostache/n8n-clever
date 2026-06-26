#!/bin/bash

set -e

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
export N8N_USER_FOLDER="${N8N_USER_FOLDER:-/tmp/n8n-user}"

mkdir -p "$N8N_USER_FOLDER"
chmod 700 "$N8N_USER_FOLDER" || true

if [ -z "$N8N_HOST" ]; then
  export N8N_HOST="$(echo "$APP_ID" | tr '_' '-').cleverapps.io"
fi

echo "Host: $N8N_HOST"
echo "Port: $N8N_PORT"
echo "N8N_USER_FOLDER: $N8N_USER_FOLDER"
ls -ld "$N8N_USER_FOLDER"

echo "n8n binary:"
command -v n8n

echo "n8n version:"
n8n --version

echo "Starting n8n..."
exec n8n
