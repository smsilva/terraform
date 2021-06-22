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

output "name" {
  value = var.ports
}