#!/bin/sh
sleep 40

python3 manage.py makemigrations

python3 manage.py migrate

python3 manage.py runserver 0:$1