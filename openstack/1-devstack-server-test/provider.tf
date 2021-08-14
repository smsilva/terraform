terraform {
  required_version = ">= 0.15.0"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.43.0"
    }
  }
}

provider "openstack" {
  cloud = "openstack"
}
