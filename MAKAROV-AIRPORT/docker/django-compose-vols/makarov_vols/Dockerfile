# syntax=docker/dockerfile:1.4

# Étape 1 : Builder (construction des dépendances et compilations nécessaires)
FROM python:3.10-alpine AS builder
WORKDIR /app

# Installer les dépendances nécessaires à la construction (mais pas en runtime)
RUN apk add --no-cache --virtual .build-deps \
    gcc musl-dev libffi-dev openssl-dev

# Copier uniquement ce qui est nécessaire pour installer les dépendances
COPY ./requirements.txt /app
RUN pip3 install --prefix=/install --no-cache-dir -r requirements.txt

# Étape 2 : Image finale minimale
FROM python:3.10-alpine
WORKDIR /app

# Copier les dépendances installées depuis l'étape de build
COPY --from=builder /install /usr/local

# Copier uniquement les fichiers nécessaires de l'application
COPY . /app
COPY ./wait-for-it.sh /wait-for-it.sh

# Configurer les autorisations
RUN chmod +x /wait-for-it.sh

# Commande d'entrée
ENTRYPOINT ["sh", "-c"]
CMD ["/wait-for-it.sh"]
