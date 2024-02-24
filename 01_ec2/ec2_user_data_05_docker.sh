#!/bin/bash

# Loading variables from .env file
source $PWD/.env

echo " > Installing docker."
yum install -y docker
echo " > Creating the docker user and group."
usermod -a -G docker $LOCAL_USER
newgrp docker
echo " > Configuring the Docker daemon to enable state and start on boot."
systemctl enable docker.service
systemctl start docker.service
echo " > Verifying that the $LOCAL_USER can run Docker commands without using sudo."
docker ps
sleep 4
echo " > Verifying the docker version."
docker --version
sleep 4
echo " > Downloading the docker-compose binary."
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
echo " > Applying execute permissions to the binary."
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
echo " > Applying execute permissions to the binary."
chmod -v +x /usr/local/bin/docker-compose
echo " > Verifying the docker-compose version."
docker-compose --version
sleep 4
