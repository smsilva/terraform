variable "ports" {
  type = list(object({
    number = number
    protocol = string
  }))
  default = [
    {
      number = 80
      protocol = "http"
    },
    {
      number = 443
      protocol = "https"
    }
  ]
}

output "list-1" {
  value = {
    for key, value in var.ports : key => value.number
  }
}

output "list-2" {
  value = {
    for port in var.ports: "${port.protocol}-${port.number}" => port
  }
}

output "list-3" {
  value = {
    for port in var.ports: "${port.protocol}" => port.number
  }
}