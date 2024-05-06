#!/bin/bash
set -e

# Check if server.pid exists and remove it to prevent server startup issues.
rm -f /app/tmp/pids/server.pid

# Wait for Postgres to start
echo "Waiting for postgres..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "PostgreSQL started"

# Execute any passed command
exec "$@"
