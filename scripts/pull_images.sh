#!/bin/bash
sudo systemctl start docker
# Pull images
sudo docker pull controlplane:5000/web-rest-1
sudo docker pull controlplane:5000/web-rest-2
sudo docker pull controlplane:5000/web-rest-3
sudo docker pull controlplane:5000/web-rest-4
sudo docker pull controlplane:5000/micro1
sudo docker pull controlplane:5000/micro2
sudo docker pull controlplane:5000/micro3
sudo docker pull controlplane:5000/djangopache