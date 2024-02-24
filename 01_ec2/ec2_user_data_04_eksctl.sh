#!/bin/bash

echo " > Download EKS CLI https://github.com/weaveworks/eksctl."
PLATFORM=$(uname -s)_amd64
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
echo " > Extract the downloaded file."
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
echo " > Move the extracted binary to /usr/local/bin."
sudo mv /tmp/eksctl /usr/local/bin
echo " > Apply execute permissions to the binary."
export PATH=$PATH:/usr/local/bin
echo " > Export the \$PATH to the shell initialization file."
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
echo " > Verifying the eksctl version."
eksctl version
sleep 4
