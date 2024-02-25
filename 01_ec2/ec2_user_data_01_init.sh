#!/bin/bash

# Loading variables from .env file
source $PWD/.env
LOCAL_KEYS_PATH=$LOCAL_USER_HOME/.ssh/$EKSCTL_SSH_PUBLIC_KEY

echo " > Updating the system."
sudo yum update -y
sleep 4
echo " > Installing the required openssl package."
sudo yum list available openssl
sudo yum update -y openssl
openssl version
sleep 4

echo "---------------------------------------------------------------------"
echo " "
echo " > Please fill the Private Key of AWS EC2 instance:"
echo " "
echo "---------------------------------------------------------------------"
sleep 4
sudo rm $LOCAL_KEYS_PATH.pem
sudo rm $LOCAL_KEYS_PATH.pub
sudo nano $LOCAL_KEYS_PATH.pem
echo " > Exporting the SSH public key."
ssh-keygen -y -f $LOCAL_KEYS_PATH.pem > $LOCAL_KEYS_PATH.pub
sudo chmod 400 $LOCAL_KEYS_PATH.pem
sudo chmod 400 $LOCAL_KEYS_PATH.pub
