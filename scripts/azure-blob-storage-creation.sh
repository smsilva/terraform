#!/bin/bash

set -e

LOCATION="centralus"
RESOURCE_GROUP_NAME="iac"
STORAGE_ACCOUNT_NAME="${USER}"
CONTAINER_NAME="terraform"

# Create resource group
az group create \
  --name ${RESOURCE_GROUP_NAME?} \
  --location ${LOCATION?}

# Create storage account
az storage account create \
  --resource-group ${RESOURCE_GROUP_NAME?} \
  --name ${STORAGE_ACCOUNT_NAME?} \
  --sku Standard_LRS \
  --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group ${RESOURCE_GROUP_NAME?} \
  --account-name ${STORAGE_ACCOUNT_NAME?} \
  --query '[0].value' \
  --output tsv)

# Create blob container
az storage container create \
  --name ${CONTAINER_NAME?} \
  --account-name ${STORAGE_ACCOUNT_NAME?} \
  --account-key ${ACCOUNT_KEY?}

echo "STORAGE_ACCOUNT_NAME.: ${STORAGE_ACCOUNT_NAME}"
echo "CONTAINER_NAME.......: ${CONTAINER_NAME}"
echo "ACCOUNT_KEY..........: ${ACCOUNT_KEY}"
