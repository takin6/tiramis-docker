#!/bin/sh
set -ex

if [ ! -d /app/tmp/pids ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir -p /app/tmp/pids
fi

if [ ! -d /app/log ]; then
  mkdir -p /app/log
  touch /app/log/development-batch.log
  touch /app/log/development.log
fi

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

echo "Waiting for MySQL to start..."
while ! mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USERNAME" -p"$DB_PASSWORD"; do
  sleep 1
done

bundle check || bundle install --jobs=4 --retry=3

echo "Running migrations..."

rails db:migrate 2>/dev/null || rails db:setup

bundle exec sidekiq -C config/sidekiq.yml

rails server -b 0.0.0.0

