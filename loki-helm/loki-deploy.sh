#!/bin/bash

# Helm update and install
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Create a Helm release of Loki with Grafana + Prometheus using a PVC
# NOTE: This diverges from the Loki docs as it uses storageClassName=default instead of "standard" 
kubectl create namespace grafana
helm upgrade --install loki grafana/loki-stack --namespace grafana --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false,loki.persistence.enabled=true,loki.persistence.storageClassName=default,loki.persistence.size=5Gi

# The Helm installation uses a non-default password for Grafana.  This command fetches it.
# Should look like gtssNbfacGRYZFCa4f3CFmMuendaZzrf9so9VgLh
kubectl get secret loki-grafana -n grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Port-forward from the Grafana service (port 80) to your desktop (port 3000)
kubectl port-forward -n grafana svc/loki-grafana 3000:80

# In your browser, go to http://127.0.0.1:3000/
# User: admin
# Password: Output of the "kubectl get secret" command. 