#!/bin/bash
cd /vagrant/MAKAROV-AIRPORT/docker
COMPOSE_DIR="compose"

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

echo "All files applied."