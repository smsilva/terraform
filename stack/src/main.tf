resource "random_string" "environment_id" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 4
}

resource "null_resource" "environment" {
  triggers = {
    name                      = "${var.environment_name}-${random_string.environment_id.result}"
    storage_account_base_name = "${var.environment_name}${random_string.environment_id.result}"
  }
}

resource "azurerm_resource_group" "default" {
  name     = "iac-stack-${null_resource.environment.triggers.name}"
  location = var.region
}

module "storage_account_demo" {
  source = "git@github.com:smsilva/iac-storage-account.git//src?ref=dummy"

  region               = var.region
  resource_group       = azurerm_resource_group.default
  storage_account_name = "${null_resource.environment.triggers.name}demo"
}
