module "backend" {
  source = "../modules/storage-account"

  region               = "centralus"
  resource_group_name  = "iac-temp"
  storage_account_name = "silviosiac"
}
