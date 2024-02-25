#!/bin/bash

echo "-------------------------------------------------"
echo " > Installing EBS Driver"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/ebsdriver-deploy.sh
sleep 4

echo "-------------------------------------------------"
echo " > Installing Prometheus"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/prometheus-deploy.sh
sleep 4

echo "-------------------------------------------------"
echo " > Installing Grafana"
echo "-------------------------------------------------"
echo " "
$PWD/03_monitoring/grafana-deploy.sh
sleep 4
