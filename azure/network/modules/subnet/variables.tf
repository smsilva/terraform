variable "name" {
  default = ""
}

variable "cidrs" {
  default = []
}

variable "vnet" {
  default = {
    id   = ""
    name = ""
  }
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}
