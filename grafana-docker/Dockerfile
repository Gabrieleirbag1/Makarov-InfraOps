FROM docker:latest
RUN apk add --no-cache docker-compose
COPY start.sh /start.sh
COPY docker-compose.yml /docker-compose.yml
COPY docker-compose.exporters.yml /docker-compose.exporters.yml
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]