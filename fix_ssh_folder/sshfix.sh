#!/bin/bash

# Script pour remplacer la configuration SSH sur Debian
# Allows ansible to run inside the vagrant subnetwork

# Chemin vers le fichier de configuration SSH
SSH_CONFIG="/etc/ssh/sshd_config"

# Écriture de la nouvelle configuration
sudo bash -c "cat << EOF > $SSH_CONFIG
Include /etc/ssh/sshd_config.d/*.conf

Port 22
PasswordAuthentication yes
PermitEmptyPasswords yes

KbdInteractiveAuthentication no

UsePAM yes

X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*

Subsystem       sftp    /usr/lib/openssh/sftp-server

ClientAliveInterval 600

UseDNS no
EOF"

# Redémarrer le service SSH pour appliquer les changements
sudo systemctl restart ssh

# Modifier le mot de passe de l'utilisateur "vagrant" en "vagrant"
echo "vagrant:vagrant" | sudo chpasswd