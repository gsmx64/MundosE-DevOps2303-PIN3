#!/bin/bash

echo "-------------------------------------------------"
echo " > Installing EBS Driver"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/ebsdriver-deploy.sh
sleep 4


echo " > Uninstalling Prometheus"
sudo helm uninstall prometheus --namespace prometheus kubectl delete ns prometheus

echo " > Unnstalling Grafana"
sudo helm uninstall grafana --namespace grafana kubectl delete ns grafana
rm -rf ${HOME}/environment/grafana
sleep 4

echo " > Unnstalling EKS"
eksctl delete cluster --name eks-mun