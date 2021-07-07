variable "location" {
  default = "centralus"
}

variable "project" {
  default = {
    name = "demo"
  }
}

variable "vnet" {
  default = {
    name   = "hub"
    prefix = "vnet"
  }
}
