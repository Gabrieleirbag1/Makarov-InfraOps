# #!/bin/bash

BLUE_CYAN_BOLD="\e[1;96m"
UNDERLINE="\e[4m"
RESET="\e[0m"

echo -e "${BLUE_CYAN_BOLD}Starting Vagrant...${RESET}"
vagrant up

echo -e "${BLUE_CYAN_BOLD}Waiting for Kubernetes cluster to start...${RESET}"
vagrant ssh controlplane -c "cd /vagrant/scripts && ./apply_all.sh"

echo -e "${BLUE_CYAN_BOLD}Waiting for Grafana to start...${RESET}"
vagrant ssh controlplane -c "cd /vagrant/scripts && ./install_helm.sh"

echo -e "${BLUE_CYAN_BOLD}Waiting for all pods to be ready...${RESET}"
sleep 60
vagrant ssh controlplane -c "cd /vagrant/scripts/ && ./run_grafana.sh"

default_interface=$(./select_network.sh)

ip_address=$(ip -o -4 addr list $default_interface | awk '{print $4}' | cut -d/ -f1)

echo -e "${BLUE_CYAN_BOLD}Installation complete.${RESET}"
echo -e "${BLUE_CYAN_BOLD}Web site is now available at ${UNDERLINE}http://$ip_address:8080/home/${RESET}"
echo -e "${BLUE_CYAN_BOLD}Grafana is now available at ${UNDERLINE}http://$ip_address:3030/login/${RESET}"