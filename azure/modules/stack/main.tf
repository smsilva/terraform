module "prefix" {
  source = "../test"

  name = "newvalue"
}

output "newname" {
  value = module.prefix.id
}
