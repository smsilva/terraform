output "cluster" {
  value = {
    id                  = azurerm_kubernetes_cluster.default.id
    identity            = azurerm_kubernetes_cluster.default.identity[0]
    kubelet_identity    = azurerm_kubernetes_cluster.default.kubelet_identity[0]
    node_resource_group = azurerm_kubernetes_cluster.default.node_resource_group
  }
}

output "subscription" {
  value = {
    name      = data.azurerm_subscription.default.display_name
    id        = data.azurerm_subscription.default.subscription_id
    tenant_id = data.azurerm_subscription.default.tenant_id
  }
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.default.kube_admin_config_raw
  sensitive = true
}
