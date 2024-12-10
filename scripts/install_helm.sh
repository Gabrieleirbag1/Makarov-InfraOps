#!/bin/bash
cd /vagrant/MAKAROV-AIRPORT/docker
GRAFANA_DIR="grafana-kubernetes"

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm



if [ ! -d "$GRAFANA_DIR" ]; then
  echo "Directory $GRAFANA_DIR does not exist."
  exit 1
fi

echo "Installing Grafana using Helm..."
helm upgrade --install grafana prometheus-community/grafana --namespace monitoring --create-namespace -f "$GRAFANA_DIR/values.yaml"

echo "Grafana deployed successfully."

echo "Forwarding port 3000 to Grafana service..."
kubectl port-forward svc/grafana 3000:80 -n monitoring &

sleep 5

echo "Retrieving Grafana password..."
GRAFANA_PASSWORD=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

echo "Grafana password: $GRAFANA_PASSWORD"

echo "You can now access Grafana at http://localhost:3000 with the password above."
