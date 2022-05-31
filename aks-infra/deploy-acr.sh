#!/bin/bash

# Optional If you want use 
#Create an Azure Container Registry
az acr create --resource-group $AKS_RG \
 --name $ACR_NAME --sku Basic

#Log in to the container registry
az acr login --name $ACR_NAME

#Get Login server addres
az acr list --resource-group $AKS_RG \
 --query "[].{acrLoginServer:loginServer}" \
 --output table

#Tag Images
docker tag mcr.microsoft.com/azuredocs/azure-vote-front:v1 <acrLoginServer>/azure-vote-front:v1

#Push images to registry
docker push <acrLoginServer>/azure-vote-front:v1

#List images in registry
docker push <acrLoginServer>/azure-vote-front:v1





