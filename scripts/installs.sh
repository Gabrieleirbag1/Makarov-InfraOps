#!/bin/bash

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

sudo apt-get install -y docker.io

# Add vagrant user to the docker group
sudo usermod -aG docker vagrant

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker