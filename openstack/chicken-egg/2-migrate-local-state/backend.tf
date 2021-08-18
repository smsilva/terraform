terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  backend "azurerm" {
    resource_group_name  = "iac-temp"
    storage_account_name = "silviosiac"
    container_name       = "terraform"
    key                  = "terraform.tfstate.json"
  }
}

provider "azurerm" {
  features {}
}
