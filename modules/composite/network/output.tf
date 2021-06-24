output "id" {
  value = null_resource.network.id
}

output "cidr_subnet" {
  value = null_resource.network.triggers.cidr_subnet
}
