output "vnets" {
  value = {
    hub       = azurerm_virtual_network.hub
    spoke_one = azurerm_virtual_network.spoke_one
    spoke_two = azurerm_virtual_network.spoke_two
  }
}
