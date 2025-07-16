#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Wait for the database to be ready
echo "Waiting for database to be ready..."
until pg_isready -h $POSTGRES_HOST -p 5432 -U $POSTGRES_USERNAME; do
  echo "Database is unavailable - sleeping"
  sleep 1
done
echo "Database is ready!"

# Check if database exists, if not create it
echo "Checking if database exists..."
if ! rails db:version > /dev/null 2>&1; then
  echo "Database does not exist. Creating database..."
  rails db:create
else
  echo "Database already exists."
fi

# Run migrations
echo "Running database migrations..."
rails db:migrate

echo "Starting Rails server..."
exec "$@"