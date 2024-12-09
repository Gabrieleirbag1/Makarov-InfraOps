#!/bin/bash
set -e

mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /docker-entrypoint-initdb.d/makarov_airport_dump.sql