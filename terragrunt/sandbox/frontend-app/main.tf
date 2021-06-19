terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.63.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "iac"
    storage_account_name  = "silvios"
    container_name        = "terraform"
    key                   = "sandbox/frontend-app/state.json"
  }
}

provider "azurerm" {
  tenant_id       = "a267367d-d04d-4a6b-84ef-0cc227ed6e9f"
  subscription_id = "ddc30188-075a-470d-a6ca-05a1987c51a3"
  features {}
}

locals {
    common = yamldecode(file("../variables.yaml"))
}

resource "azurerm_resource_group" "default" {
    name     = "${local.common.resource_group.name}"
    location = "${local.common.location}"
    tags     = {}
}
