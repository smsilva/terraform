locals {
    tags = {
        Environment = "${var.tag_environment_name}"
    }
}

resource "azurerm_resource_group" "default" {
    name     = "${var.resource_group_name}-${var.location}"
    location = "${var.location}"
    tags     = "${local.tags}"
}

resource "azurerm_kubernetes_cluster" "default" {
    name                = "${var.cluster_name}-${var.location}-aks"
    dns_prefix          = "${var.dns_prefix}"
    location            = azurerm_resource_group.default.location
    resource_group_name = azurerm_resource_group.default.name

    default_node_pool {
        name                         = "systempool"
        orchestrator_version         = "${var.orchestrator_version}"
        enable_auto_scaling          = true
        node_count                   = "${var.nodepool_node_count}"
        min_count                    = "${var.nodepool_min_count}"
        max_count                    = "${var.nodepool_max_count}"
        max_pods                     = "${var.nodepool_max_pods}"
        only_critical_addons_enabled = true
        type                         = "VirtualMachineScaleSets"
        vm_size                      = "${var.nodepool_vm_size}"
        os_disk_type                 = "${var.nodepool_os_disk_type}"

        upgrade_settings {
            max_surge = "${var.nodepool_default_max_surge}"
        }
    }

    network_profile {
        load_balancer_sku = "${var.load_balancer_sku}"
        network_plugin = "${var.network_plugin}"
    }

    identity {
        type = "SystemAssigned"
    }

    role_based_access_control {
        enabled = true

        azure_active_directory {
            managed                = true
            admin_group_object_ids = var.admin_group_object_ids
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
    orchestrator_version  = "${var.orchestrator_version}"
    enable_auto_scaling   = true
    node_count            = "${var.nodepool_node_count}"
    min_count             = "${var.nodepool_min_count}"
    max_count             = "${var.nodepool_max_count}"
    max_pods              = "${var.nodepool_max_pods}"
    mode                  = "User"
    vm_size               = "${var.nodepool_vm_size}"
    os_disk_type          = "${var.nodepool_os_disk_type}"
    
    upgrade_settings {
        max_surge = "${var.nodepool_user_max_surge}"
    }
}
