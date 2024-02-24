#!/bin/bash

# Variables moved to .env
# CLUSTER_NAME="mundoes-cluster-G19"
# AWS_REGION="us-east-1"
# AWS_ZONES="us-east-1a,us-east-1b,us-east-1c"

# Loading variables from .env file
source $PWD/.env

# Set AWS credentials.
aws sts get-caller-identity >> /dev/null
if [ $? -eq 0 ]
then
  echo "Tested credentials, proceeding with cluster creation."

  # Cluster creation.
  eksctl create cluster \
  --name "$EKSCTL_CLUSTER_NAME" \
  --version "$EKSCTL_VERSION" \
  --region "$AWS_REGION" \
  --zones "$AWS_ZONES" \
  --managed \
  --nodegroup-name $EKSCTL_NODEGROUP_NAME \
  --nodes $EKSCTL_NODES \
  --node-type $AWS_EC2_INSTANCE \
  --with-oidc \
  --ssh-access=true \
  --ssh-public-key $EKSCTL_SSH_PUBLIC_KEY \
  --full-ecr-access
  
  # Deploying nginx
  kubectl apply -f nginx-deployment.yaml

  if [ $? -eq 0 ]
  then
    echo "Cluster setup completed successfully with eksctl."
  else
    echo "The cluster setup failed while eksctl runs."
  fi
else
  echo "Please run aws configure & set right credentials."
  echo "Cluster setup failed."
fi
