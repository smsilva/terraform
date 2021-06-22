variable "name" {
  default = ""
}

resource "null_resource" "creator" {
  triggers = {
    name = "${var.name}-bucket"
  }
}

output "id" {
  value = null_resource.creator.triggers.name
}
