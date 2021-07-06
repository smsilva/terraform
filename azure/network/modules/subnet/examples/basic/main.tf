provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "centralus"
}

module "vnet" {
  source = "../../../vnet"

  name           = "vnet-hub"
  cidr           = ["10.0.0.0/20"]
  resource_group = azurerm_resource_group.example
}

module "subnet" {
  source = "../../"

  name           = "AzureBastionSubnet"
  cidrs          = ["10.0.1.0/29"]
  vnet           = module.vnet
  resource_group = azurerm_resource_group.example
}
