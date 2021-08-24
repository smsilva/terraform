# Demo Stack

### Configure Azure Resource Manager (ARM) Environment Variables
```bash
export ARM_SUBSCRIPTION_ID=9368d296-21c7-440d-ba08-edf5d4c7e9b2
export ARM_TENANT_ID=879c2680-0e27-44b4-a7e1-00ea5741c9af
export ARM_CLIENT_ID=03251c57-0562-430b-ab95-6089fe5ba169
export ARM_CLIENT_SECRET=YOUR_CLIENT_ID_SECRET
export ARM_ACCESS_KEY=YOUR_AZURE_STORAGE_ACCOUNT_PRIMARY_ACCESS_KEY
```

### Build Base Image
```bash
cd stack/build/base-image
./build ../../src

```

### Build Custom Image
```bash
cd ../../build/custom-image/
./build
```

### Execute a Custom Image Test
```bash
# Use DEBUG=1 to enable debug 
export DEBUG=1
export PATH=${HOME}/git/terraform/stack/scripts:${PATH}

azrun iac-stack-demo:1.5.0-sandbox plan
azrun iac-stack-demo:1.5.0-sandbox apply
azrun iac-stack-demo:1.5.0-sandbox state list
```
