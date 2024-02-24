#!/bin/bash

echo " > Verifying if sam exists and uninstall it."
sudo yum remove awscli
echo " > Downloading the lastest version of awscli."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo " > Unzip the downloaded file."
unzip awscliv2.zip
echo " > Installing the awscli."
sudo ./aws/install
sudo rm awscliv2.zip && rm -r ./aws
echo " > Verifying the awscli version."
aws --version
sleep 4
