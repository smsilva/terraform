variable "name" {
  default = "silvios"
}

resource "null_resource" "name" {
  triggers = {
    name = "${var.name}"
  }
}

output "id" {
  value = null_resource.name.triggers.name
}
