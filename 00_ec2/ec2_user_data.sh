#!/bin/bash

echo "-------------------------------------------------"
echo " > Initial setup"
echo "-------------------------------------------------"
echo " "
echo " > Updating the system."
yum update -y
sleep 4
echo " > Installing the required openssl package."
sudo yum list available openssl
yum update -y openssl
openssl version
sleep 4

echo "-------------------------------------------------"
echo "Installing AWS CLI"
echo "-------------------------------------------------"
echo " "
echo " > Verifying if sam exists and uninstall it."
yum remove awscli
echo " > Downloading the lastest version of awscli."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo " > Unzip the downloaded file."
unzip awscliv2.zip
echo " > Installing the awscli."
./aws/install
echo " > Verifying the awscli version."
aws --version
sleep 4

echo "-------------------------------------------------"
echo "Installing AWS SAM CLI"
echo "-------------------------------------------------"
echo " "
echo " > Downloading the lastest version of aws-sam-cli."
curl "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
echo " > Unzip the downloaded file."
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
echo " > Installing the aws-sam-cli."
./sam-installation/install
echo " > Verifying the aws-sam-cli version."
sam --version
sleep 4

echo "-------------------------------------------------"
echo " > Installing kubectl"
echo "-------------------------------------------------"
echo " "
echo " > Downloading the kubectl binary."
# Modified and update from https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/amd64/kubectl
curl -o kubectl curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/darwin/amd64/kubectl
echo " > Applying execute permissions to the binary."
chmod +x ./kubectl
echo " > Copying the binary to a folder in your PATH."
# Modified to use official steps: mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo " > Add the \$HOME/bin path to the shell initialization file."
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
echo " > Verifying the kubectl version."
kubectl version --client
sleep 4

echo "-------------------------------------------------"
echo " > Installing eksctl"
echo "-------------------------------------------------"
echo " "
echo " > Download EKS CLI https://github.com/weaveworks/eksctl."
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xzf -C /tmp
echo " > Move the extracted binary to /usr/local/bin."
sudo mv /tmp/eksctl /usr/local/bin
echo " > Apply execute permissions to the binary."
export PATH=$PATH:/usr/local/bin
echo " > Export the \$PATH to the shell initialization file."
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
echo " > Verifying the eksctl version."
eksctl version
sleep 4

echo "-------------------------------------------------"
echo " > Installing docker"
echo "-------------------------------------------------"
echo " "
echo " > Installing docker."
sudo yum install -y docker
echo " > Creating the docker user and group."
sudo usermod -a -G docker ec2-user
newgrp docker
echo " > Verifying that the ec2-user can run Docker commands without using sudo."
docker ps
sleep 4
echo " > Downloading the docker-compose binary."
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
echo " > Applying execute permissions to the binary."
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
echo " > Applying execute permissions to the binary."
sudo chmod -v +x /usr/local/bin/docker-compose
echo " > Configuring the Docker daemon to enable state and start on boot."
sudo systemctl enable docker.service
sudo systemctl start docker.service
echo " > Verifying the docker and docker-compose version."
docker --version
docker-compose --version
sleep 4

echo "-------------------------------------------------"
echo " > Installing Helm"
echo "-------------------------------------------------"
echo " "
echo " > Downloading the Helm binary."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
echo " > Applying execute permissions to the installer."
chmod 700 get_helm.sh
echo " > Running the installer."
./get_helm.sh
echo " > Verifying the Helm version." 
# TODO: Make a workaround to get the version without restart console.
helm version | cut -d + -f 1

echo "-------------------------------------------------"
echo "Installing terraform "
echo "-------------------------------------------------"
echo " "
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

echo "-------------------------------------------------"
echo " > Script completed!"
echo "-------------------------------------------------"