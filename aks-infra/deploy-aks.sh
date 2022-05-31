#!/bin/bash
#First use azlogin to get credentials 
az login

#create the resource group name and copy it for later use:
az group create --location $AKS_LOCATION \
                --name $AKS_RG

#Create a variable for the resource group name:
AKS_RG=rg-aks-miyake-pgc

#Create an AKS cluster:

az aks create \
--resource-group $AKS_RG \
--name $AKS_NAME \
--node-count 3 \
--generate-ssh-keys \
--node-vm-size Standard_B2s \
--enable-managed-identity

#In the Azure Portal, under All services, navigate to Kubernetes services, and verify that the cluster was deployed successfully.
#Back in the Cloud Shell, configure kubectl so that commands can be run against the cluster:
az aks get-credentials --name $AKS_NAME --resource-group $AKS_RG
