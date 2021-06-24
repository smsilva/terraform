resource "null_resource" "example" {
  triggers = {
    cidr = var.cidr_block
  }
}
