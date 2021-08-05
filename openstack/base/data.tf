data "openstack_compute_flavor_v2" "m1_tinny" {
  vcpus = 1
  ram   = 512
}

data "openstack_compute_flavor_v2" "m2_medium" {
  vcpus = 2
  ram   = 4096
}

data "openstack_images_image_v2" "cirros" {
  name        = "cirros"
  most_recent = true
}

data "openstack_images_image_v2" "ubuntu" {
  name        = "ubuntu-focal-20210720-amd64-base"
  most_recent = true
}

data "openstack_networking_network_v2" "internal" {
  name = "test"
}

data "openstack_networking_network_v2" "public" {
  name = "external"
}
