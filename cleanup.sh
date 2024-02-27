#!/bin/bash

# Loading variables from .env file
source $PWD/.env

echo "-------------------------------------------------"
echo " > Cleaning up EKS Cluster"
echo "-------------------------------------------------"
echo " "

echo " > Uninstalling Prometheus"
helm uninstall prometheus --namespace prometheus
kubectl delete ns prometheus

echo " > Uninstalling Grafana"
helm uninstall grafana --namespace grafana
kubectl delete ns grafana

echo " > Uninstalling nginx"
kubectl delete all -n default --all

echo " > Uninstalling EKS"
eksctl delete cluster --name $EKSCTL_CLUSTER_NAME

echo " "
echo "-------------------------------------------------"
echo " > Cleaning up finished."
echo "-------------------------------------------------"
echo " "
sleep 4