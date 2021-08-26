variable "stack_name" {
  description = "The Stack Base Image"
  type        = string
  default     = ""
}

variable "stack_version" {
  description = "The Stack Version which will be used as a Base Image for Instances Creation"
  type        = string
  default     = ""
}

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
