#!/bin/bash
cd /vagrant/MAKAROV-AIRPORT/docker
GRAFANA_DIR="grafana-kubernetes"

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install -y helm screen


if [ ! -d "$GRAFANA_DIR" ]; then
  echo "Directory $GRAFANA_DIR does not exist."
  exit 1
fi


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Installing Grafana using Helm..."
helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace -f "$GRAFANA_DIR/values.yaml"
if [ $? -ne 0 ]; then
  echo "Installation failed. Trying upgrade instead..."
  helm upgrade monitoring prometheus-community/kube-prometheus-stack --namespace monitoring -f "$GRAFANA_DIR/values.yaml"
fi