#!/bin/bash

echo " > Installing docker."
sudo yum install -y docker
echo " > Creating the docker user and group."
sudo usermod -aG docker $USER
# newgrp docker  # Bug? This cuts the bash script execution.
echo " > Configuring the Docker daemon to enable state and start on boot."
sudo systemctl enable docker.service
sudo systemctl start docker.service
echo " > Verifying that the $USER can run Docker commands without using sudo."
docker ps
sleep 4
echo " > Verifying the docker version."
docker --version
sleep 4
echo " > Downloading the docker-compose binary."
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
echo " > Applying execute permissions to the binary."
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
echo " > Applying execute permissions to the binary."
sudo chmod -v +x /usr/local/bin/docker-compose
echo " > Verifying the docker-compose version."
docker-compose --version
sleep 4
