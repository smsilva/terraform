variable "environment_name" {
  default = "sandbox"
}

variable "region" {
  default = "centralus"
}

resource "azurerm_resource_group" "default" {
  name     = "iac-stack-${var.environment_name}"
  location = var.region
}

resource "random_string" "environment" {
  length      = 6
  special     = false
  upper       = false
  min_numeric = 4
}

resource "null_resource" "default" {
  triggers = {
    name = "${var.environment_name}-${random_string.environment.result}"
  }
}

output "environment_name" {
  value = null_resource.default.triggers.name
}
