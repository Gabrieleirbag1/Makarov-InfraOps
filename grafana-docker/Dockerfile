FROM docker:latest
RUN apk add --no-cache docker-compose
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]