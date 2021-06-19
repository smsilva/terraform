locals {
    common = yamldecode(file("../variables.yaml"))
}

resource "azurerm_resource_group" "default" {
    name     = "${local.common.resource_group.name}"
    location = "${local.common.location}"
    tags     = {}
}
