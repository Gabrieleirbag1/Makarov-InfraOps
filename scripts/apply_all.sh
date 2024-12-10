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

for file in "$GRAFANA_DIR"/*.yaml; do
  if [ -f "$file" ]; then
    echo "Applying $file..."
    kubectl apply -f "$file"
  else
    echo "No YAML files found in $GRAFANA_DIR."
  fi
done

echo "All files in $GRAFANA_DIR applied."