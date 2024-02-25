#!/bin/bash

echo "-------------------------------------------------"
echo " > Cleaning up EKS Cluster"
echo "-------------------------------------------------"
echo " "

echo " > Uninstalling Prometheus"
sudo helm uninstall prometheus --namespace prometheus kubectl delete ns prometheus

echo " > Uninstalling Grafana"
sudo helm uninstall grafana --namespace grafana kubectl delete ns grafana
rm -rf ${HOME}/environment/grafana
sleep 4

echo " > Uninstalling EKS"
eksctl delete cluster --name eks-mun

echo " "
echo "-------------------------------------------------"
echo " > Cleaning up finished."
echo "-------------------------------------------------"
echo " "