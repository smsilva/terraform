resource "null_resource" "cluster" {
  triggers = {
    vpc_id      = var.vpc_id
    cidr_subnet = var.cidr_subnet
  }
}
