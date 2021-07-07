variable "location" {
  default = "centralus"
}

variable "resource_group" {
  default = {
    name     = ""
    location = ""
  }
}

variable "vnets" {
  default = []
}
