FROM mariadb:latest

COPY makarov_airport_dump.sql /docker-entrypoint-initdb.d/
COPY init-db.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

ENV MYSQL_DATABASE=makarov_airport
ENV MYSQL_USER=gab
ENV MYSQL_PASSWORD=toto
ENV MYSQL_ROOT_PASSWORD=toto

EXPOSE 3306