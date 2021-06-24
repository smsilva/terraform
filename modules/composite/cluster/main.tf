module "network" {
  source = "../network"

  cidr_block = var.base_cidr_block
}

module "cluster" {
  source = "../consul_cluster"

  vpc_id      = module.network.id
  cidr_subnet = module.network.cidr_subnet
}
