data "openstack_compute_flavor_v2" "medium" {
  vcpus = 2
  ram   = 4096
  name  = "m1.medium"
}

data "openstack_images_image_v2" "ubuntu" {
  name        = "ubuntu"
  most_recent = true
}

data "openstack_networking_network_v2" "shared" {
  name = "shared"
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}
