variable location {
    default = "centralus"
}

variable cluster_name {
    default = "sandbox"
}

variable resource_group_name {
    default = "sandbox"
}

variable "dns_prefix" {
    default = "silvios-sandbox"
}

variable environment_name {
    default = "sandbox"
}

variable orchestrator_version {
    default = "1.19.11"
}

variable nodepool_os_disk_type {
    default = "Managed" 
}

variable nodepool_max_pods {
    default = 150
}

variable nodepool_node_count {
    default = 1
}

variable nodepool_min_count {
    default = 1
}

variable nodepool_max_count {
    default = 1
}

variable nodepool_default_max_surge {
    default = "33%"
}

variable nodepool_user_max_surge {
    default = "50%"
}

variable nodepool_vm_size {
    default = "Standard_D4s_v3"
}

variable network_plugin {
    default = "azure"
}

variable load_balancer_sku {
    default = "Standard"
}

variable admin_group_object_ids {
    default = [
        "d5075d0a-3704-4ed9-ad62-dc8068c7d0e1"
    ]

    validation {
        condition     = length(var.admin_group_object_ids) > 0
        error_message = "Shoud you use at least one group."
    }
}
