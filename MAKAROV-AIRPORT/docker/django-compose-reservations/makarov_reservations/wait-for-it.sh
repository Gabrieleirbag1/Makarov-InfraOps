#!/bin/sh
sleep 20

python3 manage.py makemigrations

python3 manage.py migrate

python3 manage.py runserver 0:$1