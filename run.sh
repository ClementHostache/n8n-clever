#!/bin/bash
set -e
set -x

export N8N_PORT=$PORT
export N8N_PROTOCOL=https
export DB_TYPE=postgresdb
export DB_POSTGRESDB_DATABASE=$POSTGRESQL_ADDON_DB
export DB_POSTGRESDB_HOST=$POSTGRESQL_ADDON_HOST
export DB_POSTGRESDB_PORT=$POSTGRESQL_ADDON_PORT
export DB_POSTGRESDB_USER=$POSTGRESQL_ADDON_USER
export DB_POSTGRESDB_PASSWORD=$POSTGRESQL_ADDON_PASSWORD
export GENERIC_TIMEZONE="UTC"
export N8N_BASIC_AUTH_ACTIVE=true

if [ -z "$N8N_HOST" ]
then
    export N8N_HOST=$(echo "$APP_ID" | tr '_' '-').cleverapps.io
fi
echo "Host: $N8N_HOST"
env
./node_modules/.bin/n8n start
exit 1
