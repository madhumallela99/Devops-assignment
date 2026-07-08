#!/bin/bash

set -e

BACKUP_DIR="../backups"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/hotel_backup_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

echo "Creating backup..."

docker exec hotel-db pg_dump \
    -U admin \
    -d hotel \
    > "$BACKUP_FILE"

echo "--------------------------------------"
echo "Backup completed successfully."
echo "Backup file:"
echo "$BACKUP_FILE"
echo "--------------------------------------"
