#!/bin/bash
sudo chmod 666 /var/run/docker.sock

# Install Docker
sudo systemctl start docker

# Create Docker config.json with authentication details
sudo mkdir -p /home/vagrant/.docker
sudo bash -c 'cat <<EOF > /home/vagrant/.docker/config.json
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "a2FyaW10dWZhaXN0b3Vqb3Vyc2xlY29uOmthcmltdHVmYWlzdG91am91cnNsZWNvbjY3"
    }
  }
}
EOF'

# Login to Docker
docker login

# Make secret
kubectl create secret docker-registry hub-registry \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=karimtufaistoujourslecon \
  --docker-password=karimtufaistoujourslecon67 \
  --docker-email=karimtufaistoujourslecon@gmail.com

# Build images
cd /vagrant/MAKAROV-AIRPORT/docker
docker build -t karimtufaistoujourslecon/web-rest-1 django-compose-user/makarov_users/
docker build -t karimtufaistoujourslecon/web-rest-2 django-compose-vols/makarov_vols/
docker build -t karimtufaistoujourslecon/web-rest-3 django-compose-reservations/makarov_reservations/
docker build -t karimtufaistoujourslecon/web-rest-4 django-compose-structure/makarov_structure/
docker build -t karimtufaistoujourslecon/micro1 microservices-compose/
docker build -t karimtufaistoujourslecon/micro2 microservices-compose/
docker build -t karimtufaistoujourslecon/micro3 microservices-compose/
docker build -t karimtufaistoujourslecon/djangopache djangopache-compose/
docker build -t karimtufaistoujourslecon/db-airport db-compose/

# Tag images
docker tag karimtufaistoujourslecon/web-rest-1 karimtufaistoujourslecon/web-rest-1
docker tag karimtufaistoujourslecon/web-rest-2 karimtufaistoujourslecon/web-rest-2
docker tag karimtufaistoujourslecon/web-rest-3 karimtufaistoujourslecon/web-rest-3
docker tag karimtufaistoujourslecon/web-rest-4 karimtufaistoujourslecon/web-rest-4
docker tag karimtufaistoujourslecon/micro1 karimtufaistoujourslecon/micro1
docker tag karimtufaistoujourslecon/micro2 karimtufaistoujourslecon/micro2
docker tag karimtufaistoujourslecon/micro3 karimtufaistoujourslecon/micro3
docker tag karimtufaistoujourslecon/djangopache karimtufaistoujourslecon/djangopache
docker tag karimtufaistoujourslecon/db-airport karimtufaistoujourslecon/db-airport 