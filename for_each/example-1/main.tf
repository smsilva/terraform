module "prefix" {
  source = "../../modules/test"

  for_each = {
    a_group        = "eastus"
    another_group  = "westus2"
    more_one_group = "centralus"
  }
  
  name = "${each.key}_${each.value}"
}

output "newname" {
  value = module.prefix
}
