#!/bin/bash
mkdir -p ~/registry-data

docker run -d -p 5000:5000 --restart=always --name registry -v ~/registry-data:/var/lib/registry registry:2

echo '{ "insecure-registries":["localhost:5000"] }' | sudo tee /etc/docker/daemon.json

sudo systemctl restart docker

echo "Local Docker registry is running on localhost:5000"