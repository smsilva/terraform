locals {
    tags = {
        Environment = "${var.environment}"
    }
    common = yamldecode(file("./variables/${var.environment}-${var.location}.yaml"))
}

resource "azurerm_resource_group" "default" {
    name     = "${local.common.resource_group_name}-${var.location}"
    location = var.location
    tags     = local.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.common.cluster_name}-vnet"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = ["10.1.0.0/17"]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "${local.common.cluster_name}-private-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.default.name
  address_prefixes     = ["10.1.0.0/18"]
}

resource "azurerm_kubernetes_cluster" "default" {
    name                = "${local.common.cluster_name}-${var.environment}-${var.location}-aks"
    dns_prefix          = "${local.common.dns_prefix}-${var.environment}-${local.common.cluster_name}"
    location            = azurerm_resource_group.default.location
    resource_group_name = azurerm_resource_group.default.name

    default_node_pool {
        name                         = "systempool"
        orchestrator_version         = "${local.common.orchestrator_version}"
        enable_auto_scaling          = true
        node_count                   = "${local.common.nodepool_node_count}"
        min_count                    = "${local.common.nodepool_min_count}"
        max_count                    = "${local.common.nodepool_max_count}"
        max_pods                     = "${local.common.nodepool_max_pods}"
        only_critical_addons_enabled = true
        type                         = "VirtualMachineScaleSets"
        vm_size                      = "${local.common.nodepool_vm_size}"
        vnet_subnet_id               = azurerm_subnet.private_subnet.id
        os_disk_type                 = "${local.common.nodepool_os_disk_type}"

        upgrade_settings {
            max_surge = "${local.common.nodepool_default_max_surge}"
        }
    }

    network_profile {
        load_balancer_sku = "${local.common.load_balancer_sku}"
        network_plugin = "${local.common.network_plugin}"
    }

    identity {
        type = "SystemAssigned"
    }

    role_based_access_control {
        enabled = true

        azure_active_directory {
            managed                = true
            admin_group_object_ids = local.common.admin_group_object_ids
        }
    }

    addon_profile {
        oms_agent {
            enabled = false
        }

        aci_connector_linux {
            enabled = false
        }

        azure_policy {
            enabled = false
        }

        http_application_routing {
            enabled = false
        }

        kube_dashboard {
            enabled = false
        }
    }

}

resource "azurerm_kubernetes_cluster_node_pool" "default" {
    kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
    name                  = "userpool"
    orchestrator_version  = "${local.common.orchestrator_version}"
    enable_auto_scaling   = true
    node_count            = "${local.common.nodepool_node_count}"
    min_count             = "${local.common.nodepool_min_count}"
    max_count             = "${local.common.nodepool_max_count}"
    max_pods              = "${local.common.nodepool_max_pods}"
    mode                  = "User"
    vm_size               = "${local.common.nodepool_vm_size}"
    os_disk_type          = "${local.common.nodepool_os_disk_type}"
    vnet_subnet_id        = azurerm_subnet.private_subnet.id
    
    upgrade_settings {
        max_surge = "${local.common.nodepool_user_max_surge}"
    }
}

resource "azurerm_role_assignment" "resource_group" {
  scope                = azurerm_resource_group.default.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_subnet" {
  scope                = azurerm_subnet.private_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.default.kubelet_identity[0].object_id
}
