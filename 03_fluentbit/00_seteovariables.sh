#!/bin/bash

# Loading variables from .env file
source ../.env

# Moved all to .env
#export AWS_REGION="us-east-1"
#export AWS_ACCOUNT_ID="813559548525"
#export ES_DOMAIN_NAME="eksworkshop-logging"
#export ES_VERSION="7.4"
#export ES_DOMAIN_USER="eksworkshop"
#export ES_DOMAIN_PASSWORD="$(openssl rand -base64 12)_Ek1$"

# OIDC del cluster de elasticsearch
#
eksctl utils associate-iam-oidc-provider --cluster $EKSCTL_CLUSTER_NAME  --approve