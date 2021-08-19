terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  backend "azurerm" {
    resource_group_name  = "iac"
    storage_account_name = "silvios"
    container_name       = "terraform"
    key                  = "iac-demo.terraform.tfstate.json"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.72.0"
    }
  }
}

provider "azurerm" {
  features {}
}
