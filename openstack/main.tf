data "openstack_compute_flavor_v2" "m1_tinny" {
  vcpus = 1
  ram   = 512
}

data "openstack_images_image_v2" "cirros" {
  name        = "cirros"
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "openstack_compute_keypair_v2" "test-keypair" {
  name       = "my-keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAjpC1hwiOCCmKEWxJ4qzTTsJbKzndLotBCz5PcwtUnflmU+gHJtWMZKpuEGVi29h0A/+ydKek1O18k10Ff+4tyFjiHDQAnOfgWf7+b1yK+qDip3X1C0UPMbwHlTfSGWLGZqd9LvEFx9k3h/M+VtMvwR1lJ9LUyTAImnNjWG7TaIPmui30HvM2UiFEmqkr4ijq45MyX2+fLIePLRIF61p4whjHAQYufqyno3BS48icQb4p6iVEZPo4AE2o9oIyQvj2mx4dk5Y8CgSETOZTYDOR3rU2fZTRDRgPJDH9FWvQjF5tA0p3d9CoWWd2s6GKKbfoUIi8R/Db1BSPJwkqB"
}

resource "openstack_compute_instance_v2" "basic" {
  name            = "basic"
  image_id        = data.openstack_images_image_v2.cirros.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_tinny.flavor_id
  key_pair        = "microstack"
  security_groups = ["default"]

  metadata = {
    this = "that"
  }

  network {
    name = "test"
  }
}

output "image" {
  value = data.openstack_images_image_v2.cirros.id
}
