#!/bin/bash

set -e

BACKUP_DIR="../backups"

LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/*.sql | head -1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup found."
    exit 1
fi

echo "Using backup:"
echo "$LATEST_BACKUP"

echo "Dropping existing schema..."

docker exec hotel-db psql \
    -U admin \
    -d hotel \
    -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

echo "Restoring database..."

docker exec -i hotel-db psql \
    -U admin \
    -d hotel \
    < "$LATEST_BACKUP"

echo "--------------------------------------"
echo "Database restored successfully."
echo "--------------------------------------"
