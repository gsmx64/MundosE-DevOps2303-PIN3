#!/bin/bash

# Loading variables from .env file
source $PWD/.env

echo " > Updating the system."
sudo yum update -y
sleep 4
echo " > Installing the required openssl package."
sudo yum list available openssl
sudo yum update -y openssl
openssl version
sleep 4

echo " > Exporting the SSH key pair."
cat <<EOF | tee ~/.ssh/$EKSCTL_SSH_PUBLIC_KEY.pem > /dev/null
$AWS_EC2_PEM
EOF
ssh-keygen -y -f ~/.ssh/$EKSCTL_SSH_PUBLIC_KEY.pem > ~/.ssh/$EKSCTL_SSH_PUBLIC_KEY.pub
sudo chmod 400 ~/.ssh/$EKSCTL_SSH_PUBLIC_KEY.pem
sudo chmod 400 ~/.ssh/$EKSCTL_SSH_PUBLIC_KEY.pub
