#!/bin/bash

#Create persistent directories for MySQL on the VM
mkdir -p /var/lib/mysql_primary
mkdir -p /var/lib/mysql_replica
#Give access to the directories
sudo chmod -R 777 /var/lib/mysql_primary
sudo chmod -R 777 /var/lib/mysql_replica

cd /home/vagrant/copied_files

echo "====================BUILDING PRIMARY DB IMAGE..===================="
docker build -t mariadb-primary -f /home/vagrant/copied_files/dockerfiles/Dockerfile-Primary-db .

echo "====================RUNNING PRIMARY DB CONTAINER...===================="

#Run the Primary-db container
docker run -d --restart unless-stopped \
    --name mariadb-primary \
    -p 3306:3306 \
    -v /var/lib/mysql_primary:/var/lib/mysql \
    mariadb-primary
    
#docker inspect mariadb-primary | grep IPAddress

echo "====================BUILDING REPLICA DB IMAGE..===================="

#Build Replica-db image
docker build -t mariadb-replica -f /home/vagrant/copied_files/dockerfiles/Dockerfile-Replica-db .

echo "====================RUNNING REPLICA DB CONTAINER...===================="

#Run the Replica-db container
docker run -d --restart unless-stopped \
    --name mariadb-replica \
    -v /var/lib/mysql_replica:/var/lib/mysql \
    -p 3307:3306 \
    mariadb-replica