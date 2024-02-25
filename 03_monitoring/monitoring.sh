#!/bin/bash

echo "-------------------------------------------------"
echo " > Installing EBS Driver"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/ebsdriver-deploy.sh

echo "-------------------------------------------------"
echo " > Installing Prometheus"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/prometheus-deploy.sh

echo "-------------------------------------------------"
echo " > Installing Grafana"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/grafana-deploy.sh
