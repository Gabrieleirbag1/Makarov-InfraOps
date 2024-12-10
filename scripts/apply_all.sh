#!/bin/bash
cd /vagrant/MAKAROV-AIRPORT/docker
COMPOSE_DIR="compose"
GRAFANA_DIR="grafana-kubernetes"

if [ ! -d "$COMPOSE_DIR" ]; then
  echo "Directory $COMPOSE_DIR does not exist."
  exit 1
fi


for file in "$COMPOSE_DIR"/*.yaml; do
  if [ -f "$file" ]; then
    echo "Applying $file..."
    kubectl apply -f "$file"
  else
    echo "No YAML files found in $COMPOSE_DIR."
  fi
done

echo "All files in $COMPOSE_DIR applied."

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
