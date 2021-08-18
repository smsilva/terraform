terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.72.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate.json"
  }
}

provider "azurerm" {
  features {}
}
