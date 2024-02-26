#!/bin/bash

# Loading variables from .env file
source $PWD/.env

# Install Prometheus and Grafana using Helm (Package manager for kubernetes)
echo " > Adding the Helm repository for Prometheus."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo " > Adding the Helm repository for Grafana."
helm repo add grafana https://grafana.github.io/helm-charts

echo " > Updating the Helm repository."
helm repo update

echo " > Creating the namespace for Prometheus"
kubectl create namespace prometheus

echo " > Installing Prometheus on EKS"
helm install prometheus prometheus-community/prometheus \
--namespace prometheus \
--set alertmanager.persistentVolume.storageClass="gp2" \
--set server.persistentVolume.storageClass="gp2"

echo "> Verifying the Prometheus installation"
kubectl get all -n prometheus
sleep 4

# Patching the service to LoadBalancer
kubectl -n prometheus patch svc prometheus-server -p '{"spec": {"type": "LoadBalancer"}}'

# Get public domain of prometheus
PROMETHEUS_PUBLIC_DOMAIN=$(kubectl -n prometheus get svc prometheus-server | awk '{print $4}' | grep -v 'EXTERNAL-IP')

echo "---------------------------------------------------------------------"
echo " "
echo " > The external domain to view Prometheus is:"
echo "   http://$PROMETHEUS_PUBLIC_DOMAIN"
echo " "
echo "---------------------------------------------------------------------"
sleep 4

export PROMETHEUS_PUBLIC_DOMAIN
