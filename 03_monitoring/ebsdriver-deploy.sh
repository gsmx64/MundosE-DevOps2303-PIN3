#!/bin/bash

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

echo " > Verifying the storage class."
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.20"
sleep 4
