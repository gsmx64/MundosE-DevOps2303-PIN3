#!/bin/bash

# Loading variables from .env file
source $PWD/.env

echo " > Downloading the kubectl binary."
# Modified and update from https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.2/2023-03-17/bin/linux/amd64/kubectl
curl -o kubectl curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/linux/amd64/kubectl
echo " > Applying execute permissions to the binary."
chmod +x ./kubectl
echo " > Copying the binary to a folder in your PATH."
# Modified to use official steps: mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
mkdir -p $LOCAL_USER_HOME/bin && cp ./kubectl $LOCAL_USER_HOME/bin/kubectl && cp ./kubectl /usr/bin/kubectl && export PATH=$LOCAL_USER_HOME/bin:$PATH
rm ./kubectl
echo " > Add the \$LOCAL_USER_HOME/bin path to the shell initialization file."
echo 'export PATH=$PATH:$LOCAL_USER_HOME/bin' >> ~/.bashrc
echo " > Verifying the kubectl version."
kubectl version --client
sleep 4
