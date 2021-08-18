terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  backend "azurerm" {
    resource_group_name  = "${resource_group_name}"
    storage_account_name = "${storage_account_name}"
    container_name       = "${container_name}"
    key                  = "${key}"
  }
}

provider "azurerm" {
  features {}
}
