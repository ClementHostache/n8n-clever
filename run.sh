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

if [ -z "$N8N_HOST" ]

then

 export N8N_HOST=$(echo "$APP_ID" | tr '_' '-').cleverapps.io

fi

echo "Host: $N8N_HOST"
echo "=== NODE / NPM VERSION ==="
node -v
npm -v

echo "=== PACKAGE.JSON ==="
cat package.json

echo "=== SQLITE3 INSTALLED ? ==="
npm ls sqlite3 || true

echo "=== SQLITE3 FILES BEFORE REBUILD ==="
find node_modules/sqlite3 -maxdepth 5 -type f | sort || true

echo "=== SQLITE3 NATIVE BINDINGS BEFORE REBUILD ==="
find node_modules/sqlite3 -name "*.node" -type f -print || true

echo "=== REBUILD SQLITE3 RUNTIME ==="
npm rebuild sqlite3 --build-from-source --verbose

echo "=== SQLITE3 NATIVE BINDINGS AFTER REBUILD ==="
find node_modules/sqlite3 -name "*.node" -type f -print || true

echo "=== REQUIRE SQLITE3 TEST ==="
node -e "require('sqlite3'); console.log('sqlite3 require OK')" || true
env

./node_modules/.bin/n8n start

exit 1
