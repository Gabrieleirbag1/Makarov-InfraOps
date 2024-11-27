# Étape 1 : Builder (construction des dépendances et compilations nécessaires)
FROM python:3.10-alpine AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement le fichier requirements.txt dans l'image
COPY ./requirements.txt /app

# Installer les dépendances de build nécessaires et les paquets Python
RUN apk add --no-cache --virtual .build-deps \
        gcc musl-dev libffi-dev openssl-dev \
    && pip3 install --prefix=/install --no-cache-dir --prefer-binary -r requirements.txt \
    && apk del .build-deps

# Étape 2 : Image finale
FROM python:3.10-alpine

# Définir le répertoire de travail
WORKDIR /app

# Copier les dépendances Python installées depuis l'étape builder
COPY --from=builder /install /usr/local

# Copier le reste de l'application (code source) dans l'image
COPY . /app


