module "backend" {
  source = "../modules/storage-account"

  region               = "centralus"
  resource_group_name  = "silvios-demo"
  storage_account_name = "silviosdemo"
}
