variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "silvios-sandbox"
}

variable cluster_name {
    default = "sandbox"
}

variable resource_group_name {
    default = "sandbox"
}

variable location {
    default = "centralus"
}

variable orchestrator_version {
    default = "1.19.11"
}

variable nodepool_max_pods {
    default = "150"
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