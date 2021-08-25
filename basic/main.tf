resource "null_resource" "name" {
  triggers = {
    name = var.name
  }
}
