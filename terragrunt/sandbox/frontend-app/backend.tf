# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "azurerm" {
    container_name       = "terraform"
    key                  = "sandbox/frontend-app/state.json"
    resource_group_name  = "iac"
    storage_account_name = "silvios"
  }
}
