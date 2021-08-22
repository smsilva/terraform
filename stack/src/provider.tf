terraform {
  required_version = ">= 0.15.0, < 2.0.0"

  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.72.0"
    }
  }
}

provider "azurerm" {
  features {}
}
