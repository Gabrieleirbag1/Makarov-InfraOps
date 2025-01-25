#!/bin/bash

# Install Ansible
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

#Remove host key checking for ansible in /etc/ansible/ansible.cfg

echo "[defaults]" >> /etc/ansible/ansible.cfg
echo "host_key_checking = False" >> /etc/ansible/ansible.cfg

cat /etc/ansible/ansible.cfg