variable "environment_name" {
  default = "sandbox"
}

resource "random_string" "environment" {
  length  = 6
  special = false
}

resource "null_resource" "dummy" {
  triggers = {
    name = "${var.environment_name}-${random_string.environment.result}"
  }
}

output "environment_name" {
  value = null_resource.dummy.triggers.name
}
