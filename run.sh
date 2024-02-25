#!/bin/bash

echo "Copying the env file.sample to .env"
cp .env.sample .env
echo "---------------------------------------------------------------------"
echo " "
echo " > Please fill the .env file with your AWS credentials and settings:"
echo " "
echo "---------------------------------------------------------------------"
sleep 4
nano .env

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
chmod +x 03_monitoring/monitoring.sh
chmod +x 03_monitoring/ebsdriver-deploy.sh
chmod +x 03_monitoring/prometheus-deploy.sh
chmod +x 03_monitoring/grafana-deploy.sh
chmod +x cleanup.sh

echo " > Runing EC2 scripts."
./01_ec2/ec2_user_data.sh
sleep 4

echo " > Runing EKS scripts."
./02_eksctl/create-cluster.sh
sleep 4

echo " > Runing Monitoring scripts."
./03_monitoring/monitoring.sh
sleep 4

# Loading variables from .env file
source $PWD/.env

echo " "
echo "---------------------------------------------------------------------"
echo " "
echo " > MundosE PIN3 has finished! - By Gonzalo Mahserdjian"
echo " "
echo " > Access to nginx: http://$NGINX_PUBLIC_DOMAIN"
echo " > Access to prometheus: http://$PROMETHEUS_PUBLIC_DOMAIN:$PROMETHEUS_PUBLIC_PORT"
echo " > Access to grafana: http://$GRAFANA_PUBLIC_DOMAIN::$GRAFANA_PUBLIC_PORT"
echo "   Grafana admin password is: $GRAFANA_ADMIN_PASSWORD"
echo " "
echo "---------------------------------------------------------------------"
sleep 10
