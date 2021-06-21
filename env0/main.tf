terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "0.0.9"
    }
  }
}

provider "env0" {
}

resource "env0_project" "example" {
  name        = "example"
  description = "Example project"
}
