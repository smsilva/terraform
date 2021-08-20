# Demo Stack

### Configure Azure Resource Manager (ARM) Environment Variables
```bash
export ARM_SUBSCRIPTION_ID=9368d296-21c7-440d-ba08-edf5d4c7e9b2
export ARM_TENANT_ID=879c2680-0e27-44b4-a7e1-00ea5741c9af
export ARM_CLIENT_ID=03251c57-0562-430b-ab95-6089fe5ba169
export ARM_CLIENT_SECRET=YOUR_CLIENT_ID_SECRET
export ARM_ACCESS_KEY=YOUR_AZURE_STORAGE_ACCOUNT_PRIMARY_ACCESS_KEY
```

### Build Docker Images
```bash
./build
```

### Execute a Plan followed by an Apply with -auto-approve
```bash
./test
```
