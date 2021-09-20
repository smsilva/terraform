variable "environment_name" {
  description = "Environment Name that will be used to generate the Resource Names"
  type        = string
  default     = ""
}

variable "region" {
  description = "Azure Region in which the Resources will live on"
  type        = string
  default     = ""
}
