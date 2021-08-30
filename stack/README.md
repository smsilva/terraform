# Demo Stack

### Configure Azure Resource Manager (ARM) Environment Variables
```bash
export ARM_SUBSCRIPTION_ID=9368d296-21c7-440d-ba08-edf5d4c7e9b2
export ARM_TENANT_ID=879c2680-0e27-44b4-a7e1-00ea5741c9af
export ARM_CLIENT_ID=03251c57-0562-430b-ab95-6089fe5ba169
export ARM_CLIENT_SECRET=YOUR_CLIENT_ID_SECRET
export ARM_STORAGE_ACCOUNT_NAME=YOUR_AZURE_STORAGE_ACCOUNT_NAME
export ARM_STORAGE_ACCOUNT_CONTAINER_NAME=YOUR_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME
export ARM_ACCESS_KEY=YOUR_AZURE_STORAGE_ACCOUNT_PRIMARY_ACCESS_KEY
```

### Clone this Repository into your Linux Home Folder
```bash
git clone https://github.com/smsilva/terraform.git ${HOME}/git/terraform
```

### Build Base Image
```bash
cd ${HOME}/git/terraform/stack/build/base-image

./build ../../src
```

### Build Custom Image
```bash
cd ${HOME}/git/terraform/stack/build/custom-image/

./build
```

### Execute a Custom Image Test
```bash
export PATH=${HOME}/git/terraform/stack/scripts:${PATH}

# Use DEBUG=1 to enable debug
export DEBUG=1

# Running Base Image
azrun iac-stack:1.0.0 plan
azrun iac-stack:1.0.0 apply

# Use DEBUG=0 to disable debug to retrieve only the outputs
export DEBUG=0
azrun iac-stack:1.0.0 output
azrun iac-stack:1.0.0 state list

# Customizing Environment Variables
export ENVIRONMENT_NAME="xpto"
export ENVIRONMENT_REGION="eastus2"

azrun iac-stack:1.0.0 plan
azrun iac-stack:1.0.0 apply
azrun iac-stack:1.0.0 show -json
```
