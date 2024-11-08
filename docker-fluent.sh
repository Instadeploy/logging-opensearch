#!/bin/bash

# rebuild-fluentd.sh
echo "Stopping Fluentd container..."
docker-compose stop fluentd

echo "Removing Fluentd container..."
docker-compose rm -f fluentd

echo "Cleaning up Fluentd buffer..."
docker volume rm logging_fluentd_buffer

echo "Rebuilding Fluentd container..."
docker-compose build fluentd

echo "Starting Fluentd container..."
docker-compose up -d fluentd

echo "Showing Fluentd logs..."
docker-compose logs -f fluentd