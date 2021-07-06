variable "name" {
  default = ""
}

variable "cidr" {
  default = ""
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}

variable "subnets" {
  default = []
}