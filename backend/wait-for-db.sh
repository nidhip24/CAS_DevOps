#!/bin/sh
while ! nc -z db 3306; do
  echo "Waiting for the database to be ready..."
  sleep 2
done
echo "Database is ready!"
