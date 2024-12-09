#!/bin/bash
systemctl start docker
# Pull images
docker pull karimtufaistoujourslecon/web-rest-1
docker pull karimtufaistoujourslecon/web-rest-2
docker pull karimtufaistoujourslecon/web-rest-3
docker pull karimtufaistoujourslecon/web-rest-4
docker pull karimtufaistoujourslecon/micro1
docker pull karimtufaistoujourslecon/micro2
docker pull karimtufaistoujourslecon/micro3
docker pull karimtufaistoujourslecon/djangopache
docker pull karimtufaistoujourslecon/db-airport