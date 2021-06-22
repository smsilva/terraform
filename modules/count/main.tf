module "prefix" {
  source = "../test"
  count = 3

  name = "newvalue-${count.index}"
}

output "newname" {
  value = module.prefix[*].id
}
