locals {
  vnets = {
    hub = {
      name          = "${var.project.name}-${var.location}-vnet-hub"
      address_space = ["10.0.0.0/20"]
    }
    spoke_one = {
      name          = "${var.project.name}-${var.location}-vnet-spoke-one"
      address_space = ["10.100.0.0/16"]
    }
    spoke_two = {
      name          = "${var.project.name}-${var.location}-vnet-spoke-two"
      address_space = ["10.200.0.0/16"]
    }
  }
  snets = {
    snet_bastion = {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.0.1.0/29"]
    }
    snet_vpn_gateway = {
      name             = "${var.project.name}-${var.location}-snet-vpn-gateway"
      address_prefixes = ["10.0.2.0/27"]
    }
    snet_firewall = {
      name             = "${var.project.name}-${var.location}-snet-firewall"
      address_prefixes = ["10.0.3.0/29"]
    }
    snet_resources = {
      name             = "${var.project.name}-${var.location}-snet-spoke-resources"
      address_prefixes = ["10.100.0.0/16"]
    }
  }
}

resource "azurerm_resource_group" "default" {
  name     = "${var.project.name}-${var.location}"
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = local.vnets.hub.name
  address_space       = local.vnets.hub.address_space
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_virtual_network" "spoke_one" {
  name                = local.vnets.spoke_one.name
  address_space       = local.vnets.spoke_one.address_space
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_virtual_network" "spoke_two" {
  name                = local.vnets.spoke_two.name
  address_space       = local.vnets.spoke_two.address_space
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_subnet" "snet_vpn_gateway" {
  name                 = local.snets.snet_vpn_gateway.name
  address_prefixes     = local.snets.snet_vpn_gateway.address_prefixes
  virtual_network_name = azurerm_virtual_network.hub.name
  resource_group_name  = azurerm_resource_group.default.name
}

resource "azurerm_subnet" "snet_firewall" {
  name                 = local.snets.snet_firewall.name
  address_prefixes     = local.snets.snet_firewall.address_prefixes
  virtual_network_name = azurerm_virtual_network.hub.name
  resource_group_name  = azurerm_resource_group.default.name
}

resource "azurerm_subnet" "snet_resources" {
  name                 = local.snets.snet_resources.name
  address_prefixes     = local.snets.snet_resources.address_prefixes
  virtual_network_name = azurerm_virtual_network.spoke_one.name
  resource_group_name  = azurerm_resource_group.default.name
}

resource "azurerm_subnet" "azure_bastion_subnet" {
  name                 = "AzureBastionSubnet"
  address_prefixes     = local.snets.snet_bastion.address_prefixes
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.hub.name
}

resource "azurerm_public_ip" "pip_hub_bastion" {
  name                = "pip_hub_bastion"
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_bastion_host" "hub_bastion" {
  name                = "hub_bastion"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azure_bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.pip_hub_bastion.id
  }
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_one" {
  name                      = "hubtospokeone"
  resource_group_name       = azurerm_resource_group.default.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_one.id
}

resource "azurerm_virtual_network_peering" "spoke_one_to_hub" {
  name                      = "spokeonetohub"
  resource_group_name       = azurerm_resource_group.default.name
  virtual_network_name      = azurerm_virtual_network.spoke_one.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
}

resource "azurerm_network_interface" "nic_example" {
  name                = "nic-example"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name                          = "exampleconfiguration"
    subnet_id                     = azurerm_subnet.snet_resources.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  size                = "Standard_F2"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nic_example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
