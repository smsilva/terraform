output "id" {
  value = module.cluster.id
}

output "network" {
  value = {
    id          = module.network.id
    cidr_subnet = module.network.cidr_subnet
  }
}
