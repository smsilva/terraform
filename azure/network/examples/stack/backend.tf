terraform {
  backend "azurerm" {
    container_name       = "terraform"
    key                  = "network-vnet.json"
    resource_group_name  = "iac"
    storage_account_name = "silvios"
  }
}

provider "azurerm" {
  features {}
}
