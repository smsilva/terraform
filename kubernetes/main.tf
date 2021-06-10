resource "azurerm_resource_group" "default" {
    name     = "sandbox-centralus"
    location = "centralus"
}

resource "azurerm_kubernetes_cluster" "default" {
    name                = "sandbox-centralus-aks"
    dns_prefix          = "silvios-sandbox"
    location            = azurerm_resource_group.default.location
    resource_group_name = azurerm_resource_group.default.name

    default_node_pool {
        name                         = "systempool"
        orchestrator_version         = "1.19.11"
        enable_auto_scaling          = true
        node_count                   = 1
        min_count                    = 1
        max_count                    = 5
        max_pods                     = 150
        only_critical_addons_enabled = true
        type                         = "VirtualMachineScaleSets"
        vm_size                      = "Standard_D4s_v3"
        os_disk_type                 = "Managed"

        upgrade_settings {
            max_surge = "33%"
        }
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "azure"
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

    tags = {
        Environment = "Sandbox"
    }
}

resource "azurerm_kubernetes_cluster_node_pool" "default" {
    kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
    name                  = "userpool"
    enable_auto_scaling   = true
    node_count            = 1
    min_count             = 1
    max_count             = 5
    max_pods              = 150
    mode                  = "User"
    vm_size               = "Standard_D4s_v3"
    os_disk_type          = "Managed"
    
    upgrade_settings {
        max_surge = "50%"
    }
}
