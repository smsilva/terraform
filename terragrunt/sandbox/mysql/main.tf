locals {
    common = yamldecode(file("../variables.yaml"))
}

resource "azurerm_resource_group" "default" {
    name     = "${local.common.resource_group.name}-mysql"
    location = "${local.common.location}"
    tags     = {}
}
