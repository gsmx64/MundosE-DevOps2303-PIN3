#!/bin/bash

echo " > Downloading the Helm binary."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
echo " > Applying execute permissions to the installer."
chmod 700 get_helm.sh
echo " > Running the installer."
./get_helm.sh
echo " > Verifying the Helm version." 
# TODO: Make a workaround to get the version without restart console.
helm version | cut -d + -f 1
sleep 4