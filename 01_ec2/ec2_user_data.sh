#!/bin/bash

echo "-------------------------------------------------"
echo " > Initial setup"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_01_init.sh

echo "-------------------------------------------------"
echo "Installing AWS CLI"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_02_awscli.sh

echo "-------------------------------------------------"
echo " > Installing kubectl"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_03_kubectl.sh

echo "-------------------------------------------------"
echo " > Installing eksctl"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_04_eksctl.sh

echo "-------------------------------------------------"
echo " > Installing docker"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_05_docker.sh

echo "-------------------------------------------------"
echo " > Installing Helm"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_06_helm.sh

echo "-------------------------------------------------"
echo "Installing terraform"
echo "-------------------------------------------------"
echo " "
$PWD/01_ec2/ec2_user_data_07_terraform.sh

echo "-------------------------------------------------"
echo " > Script completed!"
echo "-------------------------------------------------"