module "backend" {
  source = "../modules/storage-account"

  region               = var.region
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
}

data "template_file" "backend" {
  template = file("${path.module}/../templates/backend.tf")

  vars = {
    resource_group_name  = module.backend.resource_group.name
    storage_account_name = module.backend.storage_account.name
    container_name       = module.backend.storage_container.name
    key                  = "terraform.tfstate.json"
  }
}

resource "local_file" "backend" {
  content         = data.template_file.backend.rendered
  filename        = "${path.module}/../2-migrate-local-state/backend.tf"
  file_permission = "0644"
}
