data "azurerm_subscription" "default" {
}

data "azurerm_client_config" "default" {
}

resource "azurerm_resource_group" "default" {
  name     = "${var.cluster_name}-${var.location}"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "silvios-${var.cluster_name}"
  dns_prefix          = "silvios-${var.cluster_name}-env"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    node_count          = 1
    min_count           = 1
    max_count           = 5
    max_pods            = 50
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "azure"
    network_policy    = "azure"
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
