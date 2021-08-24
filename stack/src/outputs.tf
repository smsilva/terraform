output "input_environment_name" {
  value = var.environment_name
}

output "environment_name" {
  value = null_resource.default.triggers.name
}

output "stack_version" {
  value = var.stack_version
}
