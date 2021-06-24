variable "base_cidr_block" {
  default = ""

  validation {
    condition     = length(var.base_cidr_block) > 0
    error_message = "You should inform a CIDR base block."
  }
}
