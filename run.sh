#!/bin/bash

echo "Copying the env file.sample to .env"
cp .env.sample .env
echo "---------------------------------------------------------------------"
echo " "
echo " > Please fill the .env file with your AWS credentials and settings."
echo " "
echo "---------------------------------------------------------------------"
sleep 6
nano .env
sleep 4

echo " > Making the scripts executable."
chmod +x 01_ec2/ec2_user_data.sh
chmod +x 01_ec2/ec2_user_data_01_init.sh
chmod +x 01_ec2/ec2_user_data_02_awscli.sh
chmod +x 01_ec2/ec2_user_data_03_kubectl.sh
chmod +x 01_ec2/ec2_user_data_04_eksctl.sh
chmod +x 01_ec2/ec2_user_data_05_docker.sh
chmod +x 01_ec2/ec2_user_data_06_helm.sh
chmod +x 01_ec2/ec2_user_data_07_terraform.sh
chmod +x 02_eksctl/create-cluster.sh
chmod +x 02_eksctl/configmap.sh
chmod +x 03_monitoring/prometheus-deploy.sh
chmod +x 03_monitoring/grafana-deploy.sh

echo " > Runing EC2 user data scripts."
./01_ec2/ec2_user_data.sh
sleep 4

echo " > Runing EKS user data scripts."
./02_eksctl/create-cluster.sh
sleep 4
