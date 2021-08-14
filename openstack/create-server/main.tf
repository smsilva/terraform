data "openstack_compute_keypair_v2" "default" {
  name = "silvios"
}

data "openstack_compute_flavor_v2" "medium" {
  vcpus = 2
  ram   = 4096
  name  = "m1.medium"
}

variable "image_name" {
  type = string
  default = "focal-server-cloudimg-amd64"
}

data "openstack_images_image_v2" "ubuntu_focal_server" {
  name        = var.image_name
  most_recent = true
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}

data "openstack_networking_network_v2" "private" {
  name = "private"
}

resource "openstack_compute_instance_v2" "demo_server_01" {
  name            = "demo-01"
  image_id        = data.openstack_images_image_v2.ubuntu_focal_server.id
  flavor_id       = data.openstack_compute_flavor_v2.medium.flavor_id
  key_pair        = data.openstack_compute_keypair_v2.default.name
  security_groups = ["default"]

  network {
    name = data.openstack_networking_network_v2.private.name
  }
}

resource "openstack_compute_floatingip_v2" "floatingip_01" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_associate_v2" "floatingip_01_demo_server_01" {
  floating_ip = openstack_compute_floatingip_v2.floatingip_01.address
  instance_id = openstack_compute_instance_v2.demo_server_01.id
}
