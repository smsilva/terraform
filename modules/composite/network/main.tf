resource "null_resource" "network" {
  triggers = {
    cidr_block  = var.cidr_block
    cidr_subnet = cidrsubnet(var.cidr_block, 4, 1)
  }
}
