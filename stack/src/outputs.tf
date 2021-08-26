output "environment_name" {
  value = null_resource.environment.triggers.name
}

output "stack_name" {
  value = var.stack_name
}

output "stack_version" {
  value = var.stack_version
}
