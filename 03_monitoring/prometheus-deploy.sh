#!/bin/bash

# Loading variables from .env file
source $PWD/.env

# Install Prometheus and Grafana using Helm (Package manager for kubernetes)
echo " > Adding the Helm repository for Prometheus."
sudo helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo " > Adding the Helm repository for Grafana."
sudo helm repo add grafana https://grafana.github.io/helm-charts

echo " > Updating the Helm repository."
sudo helm repo update

echo " > Creating the namespace for Prometheus"
sudo kubectl create namespace prometheus

echo " > Installing Prometheus on EKS"
sudo helm install prometheus prometheus-community/prometheus \
--namespace prometheus \
--set alertmanager.persistentVolume.storageClass="gp2" \
--set server.persistentVolume.storageClass="gp2"

echo "> Verifying the Prometheus installation"
kubectl get all -n prometheus
sleep 4

echo " > Exposing Prometheus on the EC2 instance on port $PROMETHEUS_PUBLIC_PORT (Default: tcp/8080)"
kubectl port-forward -n prometheus deploy/prometheus-server $PROMETHEUS_PUBLIC_PORT:9090 --address 0.0.0.0
sleep 4
