#!/bin/bash

echo " > Installing docker."
sudo yum install -y docker
echo " > Creating the docker user and group."
sudo usermod -a -G docker $LOCAL_USER
newgrp docker
echo " > Verifying that the $LOCAL_USER can run Docker commands without using sudo."
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
