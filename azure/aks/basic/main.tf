data "azurerm_subscription" "default" {
}

data "azurerm_client_config" "default" {
}

resource "azurerm_resource_group" "default" {
  name     = "example-centralus"
  location = "centralus"
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "example-02"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "silvios-example"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed                = true
      admin_group_object_ids = ["d5075d0a-3704-4ed9-ad62-dc8068c7d0e1"]
    }
  }

}

resource "azurerm_role_assignment" "resource_group" {
  scope                = azurerm_resource_group.default.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}

output "cluster" {
  value = {
    id               = azurerm_kubernetes_cluster.default.id
    identity         = azurerm_kubernetes_cluster.default.identity[0]
    kubelet_identity = azurerm_kubernetes_cluster.default.kubelet_identity[0]
  }
}

output "subscription" {
  value = {
    name      = data.azurerm_subscription.default.display_name
    id        = data.azurerm_subscription.default.subscription_id
    tenant_id = data.azurerm_subscription.default.tenant_id
  }
}
