provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

locals {
  name = "vnet-hub"
  cidr = ["10.0.0.0/20"]

  subnets = [
    { cidr = "10.0.1.0/29", name = "AzureBastionSubnet" },
    { cidr = "10.0.2.0/27", name = "snet_vpn_gateway" },
    { cidr = "10.0.3.0/29", name = "snet_firewall" },
  ]
}

module "vnet" {
  source = "../../"

  name           = local.name
  cidr           = local.cidr
  subnets        = local.subnets
  resource_group = azurerm_resource_group.example
}

output "subnets" {
  value = module.vnet.vnet
}
