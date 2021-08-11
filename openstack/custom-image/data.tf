data "openstack_compute_flavor_v2" "m1_medium" {
  vcpus = 2
  ram   = 4096
  name = "m1.medium"
}

data "openstack_networking_network_v2" "private" {
  name = "private"
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
