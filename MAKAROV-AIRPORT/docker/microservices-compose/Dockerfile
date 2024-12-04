# syntax=docker/dockerfile:1.4

# Etape 1 Builder (construction des dépendances et compilations nécessaires)
FROM python:3.10-alpine AS builder
WORKDIR /app

COPY ./requirements.txt /app

RUN apk add --no-cache --virtual .build-deps \
        gcc musl-dev libffi-dev openssl-dev \
    && pip3 install --prefix=/install --no-cache-dir --prefer-binary -r requirements.txt \
    && apk del .build-deps

# Etape 2 Image finale
FROM python:3.10-alpine

WORKDIR /app

COPY --from=builder /install /usr/local

COPY . /app


