# Terraform State

## Chicken and egg problem

```bash
# Configure Credentials
export ARM_CLIENT_ID=5b112d00-5638-4291-bb55-3bc89b675f1b
export ARM_TENANT_ID=6894aeef-9bc7-4596-a8c0-ce0905a22a78
export ARM_CLIENT_SECRET=YOUR_CLIENT_SECRET_HERE
export ARM_SUBSCRIPTION_ID=e4a1327d-2729-48e5-9279-fd24a638ad67

# Create Resource Group, Storage Account and Storage Container using a Local State File
terraform -chdir=./1-storage-account-creation init

terraform -chdir=./1-storage-account-creation plan

terraform -chdir=./1-storage-account-creation apply

# Retrieve Storage Account Primary Access Key
export ARM_ACCESS_KEY=$(terraform -chdir=./1-storage-account-creation output --raw primary_access_key)

# Initiate Remote State
terraform -chdir=./2-migrate-local-state init

# Push Local State to Remote State
terraform -chdir=./2-migrate-local-state state push ${PWD}/1-storage-account-creation/terraform.tfstate.json

terraform -chdir=./2-migrate-local-state state list

# Remove unecessary State Records
terraform -chdir=./2-migrate-local-state state rm data.template_file.backend

terraform -chdir=./2-migrate-local-state state rm local_file.backend

# Confirm Remote State Plan
terraform -chdir=./2-migrate-local-state plan

```
