locals {
  vnets = flatten([
    for key in keys(var.vnets) : [
      {
        name = key
        cidr = var.vnets[key].cidr
      }
    ]
  ])

  subnets = flatten([
    for key in keys(var.vnets) : [
      for subnet in var.vnets[key].subnets : {
        vnet_name   = key
        vnet_cidr   = var.vnets[key].cidr
        subnet_name = subnet.name
        subnet_cidr = subnet.cidr
      }
    ]
  ])

  vnets_map = {
    for vnet in local.vnets : "${vnet.name}" => vnet
  }

  subnets_map = {
    for subnet in local.subnets : "${subnet.subnet_name}" => subnet
  }
}

module "vnets" {
  for_each       = local.vnets_map
  source         = "../../../modules/vnet"
  name           = each.value.name
  cidr           = [each.value.cidr]
  resource_group = var.resource_group
}

module "subnets" {
  for_each       = local.subnets_map
  source         = "../../../modules/subnet"
  name           = each.value.subnet_name
  cidrs          = [each.value.subnet_cidr]
  vnet           = module.vnets[each.value.vnet_name].vnet
  resource_group = var.resource_group
}
