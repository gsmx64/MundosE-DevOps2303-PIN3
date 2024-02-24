#!/bin/bash

echo " > Updating the system."
yum update -y
sleep 4
echo " > Installing the required openssl package."
sudo yum list available openssl
yum update -y openssl
openssl version
sleep 4
