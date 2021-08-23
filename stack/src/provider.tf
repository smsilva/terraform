terraform {
  required_version = ">= 0.15.0, < 1.0.2"

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
