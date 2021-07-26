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

data "openstack_networking_network_v2" "internal" {
  name = "test"
}

data "openstack_networking_network_v2" "public" {
  name = "external"
}

resource "openstack_compute_floatingip_v2" "floatingip_1" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_keypair_v2" "silvios" {
  name       = "silvios"
  public_key = file("/home/silvios/.ssh/id_rsa.pub")
}

resource "openstack_compute_instance_v2" "server_1" {
  name            = "server-01"
  image_id        = data.openstack_images_image_v2.cirros.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_tinny.flavor_id
  key_pair        = openstack_compute_keypair_v2.silvios.name
  security_groups = ["default"]

  metadata = {
    this = "that"
  }

  network {
    name = data.openstack_networking_network_v2.internal.name
  }
}

output "server_1" {
  value = openstack_compute_instance_v2.server_1
  sensitive = true
}
