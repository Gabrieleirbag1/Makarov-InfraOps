#!/bin/bash
echo "Listening port 3000"
screen -dmS grafana_port_forward bash -c "kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring --address 0.0.0.0 > /dev/null 2>&1"