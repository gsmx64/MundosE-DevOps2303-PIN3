#!/bin/bash

# Loading variables from .env file
source $PWD/.env

echo "-------------------------------------------------"
echo " > Setup EBS Driver"
echo "-------------------------------------------------"
echo " "

echo " > Adding the Helm repository for the AWS EBS CSI driver."
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver

echo " > Updating the Helm repository."
helm repo update

echo " > Installing the latest release of the AWS EBS CSI driver."
helm upgrade --install aws-ebs-csi-driver \
  --namespace kube-system \
  aws-ebs-csi-driver/aws-ebs-csi-driver

echo " > Verifying the pods are running."
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver
sleep 4

#echo " > Installing the latest release of the AWS EBS CSI driver by Kustomize method."
#kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.28"
#sleep 4

echo " > Fixing bug with EBS Driver"
eksctl utils associate-iam-oidc-provider --cluster $EKSCTL_CLUSTER_NAME --region $AWS_REGION --approve

eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster $EKSCTL_CLUSTER_NAME \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --role-only \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --region ${AWS_REGION}
