#!/bin/bash
sudo systemctl start docker
# Build images
cd /vagrant/MAKAROV-AIRPORT/docker
sudo docker build -t web-rest-1 django-compose-user/makarov_users/
sudo docker build -t web-rest-2 django-compose-vols/makarov_vols/
sudo docker build -t web-rest-3 django-compose-reservations/makarov_reservations/
sudo docker build -t web-rest-4 django-compose-structure/makarov_structure/
sudo docker build -t micro1 microservices-compose/
sudo docker build -t micro2 microservices-compose/
sudo docker build -t micro3 microservices-compose/
sudo docker build -t djangopache djangopache-compose/

# Tag images
sudo docker tag web-rest-1 controlplane:5000/web-rest-1
sudo docker tag web-rest-2 controlplane:5000/web-rest-2
sudo docker tag web-rest-3 controlplane:5000/web-rest-3
sudo docker tag web-rest-4 controlplane:5000/web-rest-4
sudo docker tag micro1 controlplane:5000/micro1
sudo docker tag micro2 controlplane:5000/micro2
sudo docker tag micro3 controlplane:5000/micro3
sudo docker tag djangopache controlplane:5000/djangopache

# Push images
sudo docker push controlplane:5000/web-rest-1
sudo docker push controlplane:5000/web-rest-2
sudo docker push controlplane:5000/web-rest-3
sudo docker push controlplane:5000/web-rest-4
sudo docker push controlplane:5000/micro1
sudo docker push controlplane:5000/micro2
sudo docker push controlplane:5000/micro3
sudo docker push controlplane:5000/djangopache