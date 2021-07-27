data "openstack_compute_flavor_v2" "m2_medium" {
  vcpus = 2
  ram   = 4096
}

data "openstack_networking_network_v2" "internal" {
  name = "test"
}

data "openstack_networking_network_v2" "public" {
  name = "external"
}
