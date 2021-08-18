variable "region" {
  type    = string
  default = "centralus"
}

variable "resource_group_name" {
  type    = string
  default = "iac-temp"
}

variable "storage_account_name" {
  type    = string
  default = "silviosiac"
}

variable "container_name" {
  type    = string
  default = "terraform"
}
