#!/bin/bash

# Change to the appropriate directory
cd /vagrant/MAKAROV-AIRPORT/docker
GRAFANA_DIR="grafana-kubernetes"

# Install Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y

# Add the prometheus-community Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Check if the Grafana directory exists
if [ ! -d "$GRAFANA_DIR" ]; then
  echo "Directory $GRAFANA_DIR does not exist."
  exit 1
fi

# Create the monitoring namespace if it doesn't exist
kubectl get namespace monitoring || kubectl create namespace monitoring

# Install Grafana using Helm
echo "Installing Grafana using Helm..."
helm install grafana prometheus-community/grafana --namespace monitoring -f "$GRAFANA_DIR/values.yaml"

# Check if Grafana was deployed successfully
if [ $? -ne 0 ]; then
  echo "Grafana deployment failed."
  exit 1
fi

echo "Grafana deployed successfully."

# Forward port 3000 to Grafana service
echo "Forwarding port 3000 to Grafana service..."
kubectl port-forward svc/grafana 3000:80 -n monitoring &

sleep 5

# Retrieve the Grafana password
echo "Retrieving Grafana password..."
GRAFANA_PASSWORD=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

if [ -z "$GRAFANA_PASSWORD" ]; then
  echo "Failed to retrieve Grafana password."
  exit 1
fi

echo "Grafana password: $GRAFANA_PASSWORD"

echo "You can now access Grafana at http://localhost:3000 with the password above."