#!/bin/sh

docker-compose -f docker-compose.yml up -d
docker-compose -f docker-compose.exporters.yml up -d
tail -f /dev/null