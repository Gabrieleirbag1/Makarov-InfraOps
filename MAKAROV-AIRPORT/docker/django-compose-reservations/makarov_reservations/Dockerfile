# syntax=docker/dockerfile:1.4

# Etape 1 : Builder (construction des dépendances et compilations nécessaires)
FROM python:3.10-alpine AS builder
WORKDIR /app

COPY ./requirements.txt /app

RUN apk add --no-cache --virtual .build-deps \
    gcc musl-dev libffi-dev openssl-dev \
    && pip3 install --prefix=/install --no-cache-dir --prefer-binary -r requirements.txt


# Etape 2 : Build de l'image finale.
FROM python:3.10-alpine
WORKDIR /app

COPY --from=builder /install /usr/local
COPY . /app
COPY ./wait-for-it.sh /wait-for-it.sh

RUN python3 manage.py makemigrations \
    && chmod +x /wait-for-it.sh \

# Commande d'entrée
ENTRYPOINT ["sh", "-c"]
CMD ["/wait-for-it.sh"]